FROM python
WORKDIR /example
RUN pip install bottle requests
CMD python3 main.py
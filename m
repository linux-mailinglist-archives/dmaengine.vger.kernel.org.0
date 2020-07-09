Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41C219BB8
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2020 11:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgGIJKj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jul 2020 05:10:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53482 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIJKi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jul 2020 05:10:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06996dWB149446;
        Thu, 9 Jul 2020 09:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=QWdNI2KcHl8d0LNqiUJGkd+mHceQ/kmFO5BPcrK+Vxo=;
 b=POtcS6hvzfuM2SMl96EnB0bI8qERPKySTJoWZDifAD76mslfKaFmG8otqitXPA8BOjsY
 lIxldd8R14KAVc5mlJ6F0SZuQ/+pdhK+kNbfsSZrcds5ca8xN06yoLbupOuUvQ8ulxmq
 o9l3vxJbtNf6p6RN2IiXt7x9CCXOQBN6+SSFH55UM5zbZS7KLumYwNK0VVkz3LDRrKq7
 FfHnytS9KPBxaRTr+QQXgQIS8IHTbB15JsB2Vb/+l9qELwip3To2dQUhiQ5ynDWBQhZI
 JESAK4F5hqEzjqAIyIIFTtkOTPnLy65/CoQNDH8F/SnmfP+LEHHyOQqxUVdSc4ujr5Y2 fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 325y0aggw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 09:10:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06999I5W069476;
        Thu, 9 Jul 2020 09:10:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 325k3guk4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 09:10:36 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0699AZ9P029046;
        Thu, 9 Jul 2020 09:10:35 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 02:10:35 -0700
Date:   Thu, 9 Jul 2020 12:10:29 +0300
From:   <dan.carpenter@oracle.com>
To:     dave.jiang@intel.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: check device and channel list for empty
Message-ID: <20200709091029.GA10135@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=3
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090073
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Dave Jiang,

The patch deb9541f5052: "dmaengine: check device and channel list for
empty" from Jun 26, 2020, leads to the following static checker
warnings:

drivers/mmc/host/omap_hsmmc.c:1959 omap_hsmmc_probe() warn: 'host->rx_chan' can also be NULL
drivers/mmc/host/omap_hsmmc.c:1959 omap_hsmmc_probe() warn: 'host->tx_chan' can also be NULL
drivers/media/platform/xilinx/xilinx-dma.c:736 xvip_dma_init() warn: 'dma->dma' can also be NULL
drivers/spi/spi-fsl-dspi.c:520 dspi_request_dma() warn: 'dma->chan_tx' can also be NULL
drivers/spi/spi-fsl-dspi.c:528 dspi_request_dma() warn: 'dma->chan_rx' can also be NULL
drivers/iio/adc/ti_am335x_adc.c:565 tiadc_request_dma() warn: 'dma->chan' can also be NULL
drivers/iio/adc/stm32-dfsdm-adc.c:1381 stm32_dfsdm_dma_request() warn: 'adc->dma_chan' can also be NULL
drivers/iio/adc/stm32-adc.c:1837 stm32_adc_dma_request() warn: 'adc->dma_chan' can also be NULL
drivers/iio/adc/at91-sama5d2_adc.c:1520 at91_adc_dma_init() warn: 'st->dma_st.dma_chan' can also be NULL
sound/soc/ti/davinci-mcasp.c:1902 davinci_mcasp_get_dma_type() warn: 'chan' can also be NULL

drivers/mmc/host/omap_hsmmc.c
  1937  
  1938          host->rx_chan = dma_request_chan(&pdev->dev, "rx");
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The dma_request_chan() function used to only return error pointers or
a valid pointer.  We need to update the comments at the start of the
function to explain about the new NULL return.

  1939          if (IS_ERR(host->rx_chan)) {
  1940                  dev_err(mmc_dev(host->mmc), "RX DMA channel request failed\n");
  1941                  ret = PTR_ERR(host->rx_chan);
  1942                  goto err_irq;
  1943          }
  1944  
  1945          host->tx_chan = dma_request_chan(&pdev->dev, "tx");
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  1946          if (IS_ERR(host->tx_chan)) {
  1947                  dev_err(mmc_dev(host->mmc), "TX DMA channel request failed\n");
  1948                  ret = PTR_ERR(host->tx_chan);
  1949                  goto err_irq;
  1950          }
  1951  
  1952          /*
  1953           * Limit the maximum segment size to the lower of the request size
  1954           * and the DMA engine device segment size limits.  In reality, with
  1955           * 32-bit transfers, the DMA engine can do longer segments than this
  1956           * but there is no way to represent that in the DMA model - if we
  1957           * increase this figure here, we get warnings from the DMA API debug.
  1958           */
  1959          mmc->max_seg_size = min3(mmc->max_req_size,
  1960                          dma_get_max_seg_size(host->rx_chan->device->dev),
                                                     ^^^^^^^^^^^^^^^
This will Oops.

  1961                          dma_get_max_seg_size(host->tx_chan->device->dev));
  1962  
  1963          /* Request IRQ for MMC operations */
  1964          ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
  1965                          mmc_hostname(mmc), host);
  1966          if (ret) {
  1967                  dev_err(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");

regards,
dan carpenter

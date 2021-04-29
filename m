Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2864436EB16
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 15:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhD2NF1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 09:05:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41836 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhD2NF1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Apr 2021 09:05:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TCtdjY043207;
        Thu, 29 Apr 2021 13:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=5czE2LNVKkMqwUH4eVvbVg8VHTOpBxggFQh0IF0+m8w=;
 b=NNS6RS0xmJV9Wbk1NJhM+cQ3vScr1q3Ge1wxL6p32tB3VKavCFB50ZXGbpMI7Nxx3TYM
 I8FVBMgQqUTEi7acuqazZUhwBzoAjxPnaX96MJMA/eW/7cDJybinGepsXYKw2FovrY90
 NKXe4N4DhaqWTEpRcuHqI3Q85KOe4VP3SC7hQfwBfQg7V5FZcfaJuZaRwivmhHxP55oZ
 VM/P1JPFcjgatFSEzk8FznOCuqf9NUOT5WMJdon+4Z3qX5BETDt0URmsPfLRW8hfWUov
 yhvfa05M4WpNfc8ea8qKti86dWoVsfrcY5iJ8XOTvET00HPzJQwUukCwvOGgIWcAh8xd PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 385aft497k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 13:04:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TD0hFU075625;
        Thu, 29 Apr 2021 13:04:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 384w3w7swd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 13:04:12 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13TD0n7K077665;
        Thu, 29 Apr 2021 13:04:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 384w3w7sv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 13:04:11 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13TD46gr027396;
        Thu, 29 Apr 2021 13:04:07 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Apr 2021 06:04:06 -0700
Date:   Thu, 29 Apr 2021 16:03:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, quanyang.wang@windriver.com,
        Vinod Koul <vkoul@kernel.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <monstr@monstr.eu>,
        Tejas Upadhyay <tejasu@xilinx.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [kbuild] Re: [PATCH] dmaengine: xilinx: dpdma: request_irq after
 initializing dma channels
Message-ID: <202104292042.oDy299s1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429065821.3495234-1-quanyang.wang@windriver.com>
Message-ID-Hash: AV6KCQHMUA5ZIB54QXN4XFZOV2XMGAAX
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 6P2BekF4pELof5eJuHFTdsS0VnXsNMiv
X-Proofpoint-ORIG-GUID: 6P2BekF4pELof5eJuHFTdsS0VnXsNMiv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290088
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

url:    https://github.com/0day-ci/linux/commits/quanyang-wang-windriver-com/dmaengine-xilinx-dpdma-request_irq-after-initializing-dma-channels/20210429-150050 
base:   https://github.com/Xilinx/linux-xlnx  master
config: x86_64-randconfig-m001-20210429 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/dma/xilinx/xilinx_dpdma.c:1778 xilinx_dpdma_probe() warn: missing error code 'ret'

vim +/ret +1778 drivers/dma/xilinx/xilinx_dpdma.c

7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1694  static int xilinx_dpdma_probe(struct platform_device *pdev)
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1695  {
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1696  	struct xilinx_dpdma_device *xdev;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1697  	struct dma_device *ddev;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1698  	unsigned int i;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1699  	int ret;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1700  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1701  	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1702  	if (!xdev)
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1703  		return -ENOMEM;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1704  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1705  	xdev->dev = &pdev->dev;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1706  	xdev->ext_addr = sizeof(dma_addr_t) > 4;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1707  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1708  	INIT_LIST_HEAD(&xdev->common.channels);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1709  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1710  	platform_set_drvdata(pdev, xdev);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1711  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1712  	xdev->axi_clk = devm_clk_get(xdev->dev, "axi_clk");
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1713  	if (IS_ERR(xdev->axi_clk))
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1714  		return PTR_ERR(xdev->axi_clk);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1715  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1716  	xdev->reg = devm_platform_ioremap_resource(pdev, 0);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1717  	if (IS_ERR(xdev->reg))
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1718  		return PTR_ERR(xdev->reg);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1719  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1720  	ddev = &xdev->common;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1721  	ddev->dev = &pdev->dev;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1722  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1723  	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1724  	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
b305dd098dae4f Rohit Visavalia  2021-04-07  1725  	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1726  	dma_cap_set(DMA_INTERLEAVE, ddev->cap_mask);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1727  	dma_cap_set(DMA_REPEAT, ddev->cap_mask);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1728  	dma_cap_set(DMA_LOAD_EOT, ddev->cap_mask);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1729  	ddev->copy_align = fls(XILINX_DPDMA_ALIGN_BYTES - 1);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1730  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1731  	ddev->device_alloc_chan_resources = xilinx_dpdma_alloc_chan_resources;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1732  	ddev->device_free_chan_resources = xilinx_dpdma_free_chan_resources;
b305dd098dae4f Rohit Visavalia  2021-04-07  1733  	ddev->device_prep_dma_cyclic = xilinx_dpdma_prep_dma_cyclic;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1734  	ddev->device_prep_interleaved_dma = xilinx_dpdma_prep_interleaved_dma;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1735  	/* TODO: Can we achieve better granularity ? */
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1736  	ddev->device_tx_status = dma_cookie_status;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1737  	ddev->device_issue_pending = xilinx_dpdma_issue_pending;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1738  	ddev->device_config = xilinx_dpdma_config;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1739  	ddev->device_pause = xilinx_dpdma_pause;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1740  	ddev->device_resume = xilinx_dpdma_resume;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1741  	ddev->device_terminate_all = xilinx_dpdma_terminate_all;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1742  	ddev->device_synchronize = xilinx_dpdma_synchronize;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1743  	ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1744  	ddev->directions = BIT(DMA_MEM_TO_DEV);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1745  	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1746  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1747  	for (i = 0; i < ARRAY_SIZE(xdev->chan); ++i) {
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1748  		ret = xilinx_dpdma_chan_init(xdev, i);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1749  		if (ret < 0) {
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1750  			dev_err(xdev->dev, "failed to initialize channel %u\n",
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1751  				i);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1752  			goto error;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1753  		}
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1754  	}
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1755  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1756  	ret = clk_prepare_enable(xdev->axi_clk);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1757  	if (ret) {
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1758  		dev_err(xdev->dev, "failed to enable the axi clock\n");
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1759  		goto error;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1760  	}
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1761  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1762  	ret = dma_async_device_register(ddev);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1763  	if (ret) {
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1764  		dev_err(xdev->dev, "failed to register the dma device\n");
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1765  		goto error_dma_async;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1766  	}
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1767  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1768  	ret = of_dma_controller_register(xdev->dev->of_node,
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1769  					 of_dma_xilinx_xlate, ddev);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1770  	if (ret) {
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1771  		dev_err(xdev->dev, "failed to register DMA to DT DMA helper\n");
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1772  		goto error_of_dma;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1773  	}
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1774  
50d6be0a1d25af Quanyang Wang    2021-04-29  1775  	xdev->irq = platform_get_irq(pdev, 0);
50d6be0a1d25af Quanyang Wang    2021-04-29  1776  	if (xdev->irq < 0) {
50d6be0a1d25af Quanyang Wang    2021-04-29  1777  		dev_err(xdev->dev, "failed to get platform irq\n");
50d6be0a1d25af Quanyang Wang    2021-04-29 @1778  		goto error_irq;

ret = xdev->irq;

50d6be0a1d25af Quanyang Wang    2021-04-29  1779  	}
50d6be0a1d25af Quanyang Wang    2021-04-29  1780  
50d6be0a1d25af Quanyang Wang    2021-04-29  1781  	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
50d6be0a1d25af Quanyang Wang    2021-04-29  1782  			  dev_name(xdev->dev), xdev);
50d6be0a1d25af Quanyang Wang    2021-04-29  1783  	if (ret) {
50d6be0a1d25af Quanyang Wang    2021-04-29  1784  		dev_err(xdev->dev, "failed to request IRQ\n");
50d6be0a1d25af Quanyang Wang    2021-04-29  1785  		goto error_irq;
50d6be0a1d25af Quanyang Wang    2021-04-29  1786  	}
50d6be0a1d25af Quanyang Wang    2021-04-29  1787  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1788  	xilinx_dpdma_enable_irq(xdev);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1789  
1d220435cab3bf Laurent Pinchart 2020-08-12  1790  	xilinx_dpdma_debugfs_init(xdev);
1d220435cab3bf Laurent Pinchart 2020-08-12  1791  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1792  	dev_info(&pdev->dev, "Xilinx DPDMA engine is probed\n");
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1793  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1794  	return 0;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1795  
50d6be0a1d25af Quanyang Wang    2021-04-29  1796  error_irq:
50d6be0a1d25af Quanyang Wang    2021-04-29  1797  	of_dma_controller_free(pdev->dev.of_node);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1798  error_of_dma:
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1799  	dma_async_device_unregister(ddev);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1800  error_dma_async:
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1801  	clk_disable_unprepare(xdev->axi_clk);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1802  error:
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1803  	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++)
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1804  		xilinx_dpdma_chan_remove(xdev->chan[i]);
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1805  
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1806  	return ret;
7cbb0c63de3fc2 Hyun Kwon        2020-07-17  1807  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org


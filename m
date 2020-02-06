Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB0115456F
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2020 14:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgBFNuk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Feb 2020 08:50:40 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19742 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBFNuk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Feb 2020 08:50:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3c19740000>; Thu, 06 Feb 2020 05:49:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 05:50:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Feb 2020 05:50:39 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 13:50:37 +0000
Subject: Re: [PATCH v7 14/19] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200202222854.18409-1-digetx@gmail.com>
 <20200202222854.18409-15-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ca0f71ef-ba16-73bc-d904-1f5351c69931@nvidia.com>
Date:   Thu, 6 Feb 2020 13:50:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202222854.18409-15-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580996981; bh=4hvHZitSsy3srR7ePbJSExrRxuRMgu3w7SYaTU6yDGA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fsF/+l7IWaQb6/AqlvjCPk6jyI/Qn8iVdRGVfRl55Xskzw5B1P7dBHBcnS2zsqpZW
         blLxtNWeupwYqwJ5pyFURZ42FrB5cmYniUCrrFL8GdadmF2r6cOLwnp7pNdpoTgc1n
         Hxc4vKTd+Vjg1scKjwnR5yv6NLSCVkGPSLb+RS9sf5PKsd6ylWBneURin5erMiagc4
         7G0EXEagSU1JloKqwX//ot9H1TMP3uSkykX/2JlG55faTW0cyiLsZxxrOCzk7+zWb6
         KZnpFzyBfrbaIVZYTa/uyBTrvpj2+EqD5J/dJ/g8bczeCYjMN2MS8A9diKsvfcOURt
         +76eriBfUY6rg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 02/02/2020 22:28, Dmitry Osipenko wrote:
> It's a bit impractical to enable hardware's clock at the time of DMA
> channel's allocation because most of DMA client drivers allocate DMA
> channel at the time of the driver's probing, and thus, DMA clock is kept
> always-enabled in practice, defeating the whole purpose of runtime PM.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
What about something like ...

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 22b88ccff05d..d60532f19a43 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -570,6 +570,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
 	if (list_empty(&tdc->pending_sg_req)) {
 		dev_err(tdc2dev(tdc), "DMA is running without req\n");
 		tegra_dma_stop(tdc);
+		pm_runtime_put(tdc->tdma->dev);
 		return false;
 	}
 
@@ -581,6 +582,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
 	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
 	if (!hsgreq->configured) {
 		tegra_dma_stop(tdc);
+		pm_runtime_put(tdc->tdma->dev);
 		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
 		tegra_dma_abort_all(tdc);
 		return false;
@@ -616,9 +618,14 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
 	list_add_tail(&sgreq->node, &tdc->free_sg_req);
 
 	/* Do not start DMA if it is going to be terminate */
-	if (to_terminate || list_empty(&tdc->pending_sg_req))
+	if (to_terminate)
 		return;
 
+	if (list_empty(&tdc->pending_sg_req)) {
+		pm_runtime_put(tdc->tdma->dev);
+		return;
+	}
+
 	tdc_start_head_req(tdc);
 }
 
@@ -731,6 +738,10 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
 		goto end;
 	}
 	if (!tdc->busy) {
+		err = pm_runtime_get_sync(tdc->tdma->dev);
+		if (err < 0)
+			return err;
+
 		tdc_start_head_req(tdc);
 
 		/* Continuous single mode: Configure next req */
@@ -786,6 +797,8 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	}
 	tegra_dma_resume(tdc);
 
+	pm_runtime_put(tdc->tdma->dev);
+
 skip_dma_stop:
 	tegra_dma_abort_all(tdc);
 
@@ -1280,22 +1293,15 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
 static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
-	struct tegra_dma *tdma = tdc->tdma;
-	int ret;
 
 	dma_cookie_init(&tdc->dma_chan);
 
-	ret = pm_runtime_get_sync(tdma->dev);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
 static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
-	struct tegra_dma *tdma = tdc->tdma;
 	struct tegra_dma_desc *dma_desc;
 	struct tegra_dma_sg_req *sg_req;
 	struct list_head dma_desc_list;
@@ -1328,7 +1334,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 		list_del(&sg_req->node);
 		kfree(sg_req);
 	}
-	pm_runtime_put(tdma->dev);
 
 	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
 }

-- 
nvpublic

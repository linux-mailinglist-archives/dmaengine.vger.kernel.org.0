Return-Path: <dmaengine+bounces-10265-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMZEKRug/GksSAAAu9opvQ
	(envelope-from <dmaengine+bounces-10265-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 16:22:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC84EA0F5
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F56430BD4A2
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 14:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69573F9F41;
	Thu,  7 May 2026 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dHPBFWwq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E73FB7EA
	for <dmaengine@vger.kernel.org>; Thu,  7 May 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163339; cv=none; b=K1NHMFfs/8ShDFBJYm1AOTsl4/DcsXVJvBLazpGlKT3r0wA/RWfN/8IUmaU8CJXlUNV+83tKPJhElyDGkfKlCig+Oq0BF5mI5a0mryqdVF6xZyztuv6FBN5mXVG6lRjA0DoYczN3eZO+DA27fGn58plnTOaHyORQ5c2bfUS0XOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163339; c=relaxed/simple;
	bh=/1UlkLy1JukbYaTDxZhf9h8PikBoYRj5dkEmUKqa7hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhyTM/PK6qCbH0nEslA/XrRSRfkYzj08tR9ULeCkz2Vmu9f6Qp+rE0w0anMvu7D9U1+RJpcQyF72/ug51lVqwrm7l61i6bVuvWct5DHeL06JruJovap6soHS7sjgCkLZn6lzgwndQHCuQYbNkgm9Qu5Kpk5dcaL3BIZMamm/f2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dHPBFWwq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 90938C5DC5B
	for <dmaengine@vger.kernel.org>; Thu,  7 May 2026 14:16:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1E2D60495;
	Thu,  7 May 2026 14:15:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07783108194D5;
	Thu,  7 May 2026 16:15:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778163335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BBxwWahevST3lvVcvPvA5wzCA7WnP6UlZE2dbi27qno=;
	b=dHPBFWwqwQL88Rzeu/p1Gt7uEoJ7Z4sm0iDuA/Ny3GKgkmBVg3ex4gNNX37RwkRDvJrVM3
	2PMeVOqzKrjaIyaWuQFi1d4UfixjBLvn3uElrH2upplKILJAy/MwcAy1JMoM1aLPdMnk4y
	ibPEVcoPFc8OBBmDh3wIgyFZFTvEWIN0FayaKfAc8pjUY2LOPG++oxGoUi4c4zLGt2EaRg
	NDRmvFQTOO9fmlXSmIZYdHJOYZG9BPYbV1qNihYHmQUIDV/inKAmLJz8YiGB7RB4eGCATS
	zgQEBIJaK7f8ojcbauX4VQVgG8TzXCyI9ewT+PLqYLLM4nZ9J4B/fyRWwsvD6Q==
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather chaining
Date: Thu,  7 May 2026 16:15:19 +0200
Message-ID: <a658efd5a6990632def9684007573fff3e130979.1778160702.git.benoit.monin@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aftUorBAXzTD1BBD@lizhi-Precision-Tower-5810>
References: <20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com> <43uRGEDfSHihWPAxby2EOg@bootlin.com> <aftUorBAXzTD1BBD@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 1BEC84EA0F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10265-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

On Wednesday, 6 May 2026 at 16:48:02 CEST, Frank Li wrote:
> On Wed, May 06, 2026 at 04:01:37PM +0200, Benoît Monin wrote:
> > On Tuesday, 5 May 2026 at 17:07:48 CEST, Frank Li wrote:
> > > > >         how do you test it? and how much preformance improved?
> > > > I did my tests by doing SPI transfers with the LPSPI controllers, doing DMA
> > > > transactions with different number of buffers and different buffer sizes.
> > > > Without chaining, interruptions on the SPI bus occur between each DMA
> > > > transaction. With chaining, the activity on the SPI bus is continuous as
> > > > long as DMA transactions are issued before the end of the current
> > > > transaction.
> > >
> > > Does SPI support issue new transfers without wait for previous transfer
> > > complete, or SPI transfer already support async queue?
> > >
> > This is done with a local version of fsl-lpspi driver adding a simple
> > offload support by borrowing the DMA channels allocated to the SPI
> > controller. I can then issue multiple DMA transactions with the dma_buf API
> > of the IIO subsystem and trigger SG chaining.
> 
> Can you include these patches to reference?
> 
Here it is, beware that this is work in progress.

---
WIP: spi: spi-fsl-lpspi: Add Rx offload support

Add minimal support for SPI offload Currently, only the receive path
can be offloaded. SPI offload is enabled when a trigger-sources entry
is found in the device tree.

SPI offload uses the Rx DMA channel that is normally used by the
controller, thus non-offloaded SPI accesses are done in PIO mode
if offloading is enabled.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/spi/spi-fsl-lpspi.c | 180 +++++++++++++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e201309f8aae..d873581a776a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -23,6 +23,7 @@
 #include <linux/dma/imx-dma.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/types.h>
@@ -136,6 +137,12 @@ struct fsl_lpspi_data {
 	struct completion dma_rx_completion;
 	struct completion dma_tx_completion;
 
+	/* offload */
+	struct spi_offload *offload;
+	struct mutex offload_lock;
+	u32 offload_caps;
+	struct dma_chan *offload_rx_chan;
+
 	const struct fsl_lpspi_devtype_data *devtype_data;
 };
 
@@ -729,6 +736,10 @@ static int fsl_lpspi_dma_init(struct device *dev,
 {
 	int ret;
 
+	/* The DMA channels are reserved for offload */
+	if (fsl_lpspi->offload)
+		return -EBUSY;
+
 	/* Prepare for TX DMA: */
 	controller->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(controller->dma_tx)) {
@@ -889,6 +900,151 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
 	return 0;
 }
 
+static int fsl_lpspi_optimize_message(struct spi_message *msg)
+{
+	struct spi_controller *controller = msg->spi->controller;
+	struct fsl_lpspi_data *fsl_lpspi = spi_controller_get_devdata(controller);
+	struct spi_transfer *xfer;
+
+	if (!msg->offload)
+		return 0;
+
+	/* We can only offload one transfer */
+	if (!list_is_singular(&msg->transfers))
+		return -EINVAL;
+
+	/* gather info for offloaded message */
+	xfer = list_first_entry(&msg->transfers, struct spi_transfer, transfer_list);
+	fsl_lpspi->config.mode = msg->spi->mode;
+	fsl_lpspi->config.bpw = xfer->bits_per_word;
+
+	return 0;
+}
+
+static struct spi_offload
+*fsl_lpspi_get_offload(struct spi_device *spi,
+		       const struct spi_offload_config *config)
+{
+	struct spi_controller *controller = spi->controller;
+	struct fsl_lpspi_data *fsl_lpspi;
+	int ret;
+
+	fsl_lpspi = spi_controller_get_devdata(controller);
+
+	if (!fsl_lpspi->offload)
+		return ERR_PTR(-ENODEV);
+
+	if (config->capability_flags & ~fsl_lpspi->offload_caps)
+		return ERR_PTR(-EINVAL);
+
+	if (!mutex_trylock(&fsl_lpspi->offload_lock))
+		return ERR_PTR(-EBUSY);
+
+	ret = pm_runtime_resume_and_get(fsl_lpspi->dev);
+	if (ret < 0) {
+		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
+		return ERR_PTR(ret);
+	}
+
+	fsl_lpspi_reset(fsl_lpspi);
+
+	return fsl_lpspi->offload;
+}
+
+static void fsl_lpspi_put_offload(struct spi_offload *offload)
+{
+	struct fsl_lpspi_data *fsl_lpspi = offload->priv;
+
+	pm_runtime_put_autosuspend(fsl_lpspi->dev);
+
+	mutex_unlock(&fsl_lpspi->offload_lock);
+}
+
+static int fsl_lpspi_trigger_enable(struct spi_offload *offload)
+{
+	struct fsl_lpspi_data *fsl_lpspi = offload->priv;
+	enum dma_slave_buswidth buswidth;
+	struct dma_slave_config cfg = {};
+	u32 temp;
+	int ret;
+
+	switch (fsl_lpspi_bytes_per_word(fsl_lpspi->config.bpw)) {
+	case 4:
+		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	case 2:
+		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 1:
+		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* configure the DMA channel */
+	cfg.direction = DMA_DEV_TO_MEM;
+	cfg.src_addr = fsl_lpspi->base_phys + IMX7ULP_RDR;
+	cfg.src_addr_width = buswidth;
+	cfg.src_maxburst = 1;
+
+	ret = dmaengine_slave_config(fsl_lpspi->offload_rx_chan, &cfg);
+	if (ret) {
+		dev_err(offload->provider_dev, "RX dma configuration failed with %d\n",
+			ret);
+		return ret;
+	}
+	fsl_lpspi_config(fsl_lpspi);
+	fsl_lpspi_set_cmd(fsl_lpspi);
+
+	/* enable Rx DMA */
+	temp = DER_RDDE;
+	writel(temp, fsl_lpspi->base + IMX7ULP_DER);
+
+	return 0;
+}
+
+static void fsl_lpspi_trigger_disable(struct spi_offload *offload)
+{
+	struct fsl_lpspi_data *fsl_lpspi = offload->priv;
+
+	fsl_lpspi_reset(fsl_lpspi);
+}
+
+static struct dma_chan
+*fsl_lpspi_rx_stream_request_dma_chan(struct spi_offload *offload)
+{
+	struct fsl_lpspi_data *fsl_lpspi = offload->priv;
+	struct dma_slave_config cfg = {};
+	int ret;
+
+	fsl_lpspi->offload_rx_chan = dma_request_chan(offload->provider_dev, "rx");
+	if (IS_ERR(fsl_lpspi->offload_rx_chan))
+		return fsl_lpspi->offload_rx_chan;
+
+	/* set a default configuration */
+	cfg.direction = DMA_DEV_TO_MEM;
+	cfg.src_addr = fsl_lpspi->base_phys + IMX7ULP_RDR;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.src_maxburst = 1;
+
+	ret = dmaengine_slave_config(fsl_lpspi->offload_rx_chan, &cfg);
+	if (ret) {
+		dma_release_channel(fsl_lpspi->offload_rx_chan);
+		dev_err(offload->provider_dev, "RX dma configuration failed with %d\n",
+			ret);
+		return ERR_PTR(ret);
+	}
+
+	return fsl_lpspi->offload_rx_chan;
+}
+
+static const struct spi_offload_ops fsl_lpspi_offload_ops = {
+	.trigger_enable = fsl_lpspi_trigger_enable,
+	.trigger_disable = fsl_lpspi_trigger_disable,
+	.rx_stream_request_dma_chan = fsl_lpspi_rx_stream_request_dma_chan,
+};
+
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
 	const struct fsl_lpspi_devtype_data *devtype_data;
@@ -958,6 +1114,24 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (device_property_present(&pdev->dev, "trigger-sources")) {
+		fsl_lpspi->offload = devm_spi_offload_alloc(&pdev->dev, 0);
+		ret = PTR_ERR_OR_ZERO(fsl_lpspi->offload);
+		if (ret) {
+			dev_err(fsl_lpspi->dev, "failed to allocate offload\n");
+			return ret;
+		}
+		mutex_init(&fsl_lpspi->offload_lock);
+		fsl_lpspi->offload->priv = fsl_lpspi;
+		fsl_lpspi->offload->ops = &fsl_lpspi_offload_ops;
+		fsl_lpspi->offload_caps = SPI_OFFLOAD_CAP_TRIGGER;
+
+		if (device_property_match_string(&pdev->dev, "dma-names", "rx") >= 0) {
+			fsl_lpspi->offload->xfer_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+			fsl_lpspi->offload_caps |= SPI_OFFLOAD_CAP_RX_STREAM_DMA;
+		}
+	}
+
 	/* enable the clock */
 	ret = fsl_lpspi_init_rpm(fsl_lpspi);
 	if (ret)
@@ -985,6 +1159,9 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	controller->transfer_one = fsl_lpspi_transfer_one;
 	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
+	controller->optimize_message = fsl_lpspi_optimize_message;
+	controller->get_offload = fsl_lpspi_get_offload;
+	controller->put_offload = fsl_lpspi_put_offload;
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 	controller->bus_num = pdev->id;
@@ -997,7 +1174,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	if (ret == -EPROBE_DEFER)
 		goto out_pm_get;
 	if (ret < 0) {
-		dev_warn(&pdev->dev, "dma setup error %d, use pio\n", ret);
+		if (!fsl_lpspi->offload)
+			dev_warn(&pdev->dev, "dma setup error %d, use pio\n", ret);
 		enable_irq(irq);
 	}
 


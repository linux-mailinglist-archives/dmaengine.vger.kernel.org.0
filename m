Return-Path: <dmaengine+bounces-5068-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1AAAAA48B
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 01:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6E41890ABF
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 23:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA9300A2D;
	Mon,  5 May 2025 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3gx5Gr8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE30300A2A;
	Mon,  5 May 2025 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483998; cv=none; b=AiOWNhvdAJosRbCWa10ZY851QR80rOOdhEHIcXWvmPGEPwwIx6/EGH93shH+t+SoynmFqljw9os1sMR+iRXVtTym+uXOtG8LeKkSzkbtDt/kJQSPFEC5KWwGq7CiFyFvpXDlQ0TKBTno1A5o6JEz1wdt77aR2ha+OB5sX6rIFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483998; c=relaxed/simple;
	bh=OPNCmB6m5eZ7QxOxTiJ78nkIefYbTw9N3ozKkMo1GCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLGCE2IZgN0tsbnFgHkOyX0li8EnZ55KoF1k5Z4hmgm8Z1T4UzbOD/5KrAYWs6i+IboquZb+8NOWcdCjm5dc3TcfpPj8EvlPZOXVfBTkTZ2A87rSf09jx1JjjA/P0B3YOpgCB4hd4PdrAHb8v6hcudbrf6B/oytd5o+wf8TpNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3gx5Gr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A2BC4CEE4;
	Mon,  5 May 2025 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483997;
	bh=OPNCmB6m5eZ7QxOxTiJ78nkIefYbTw9N3ozKkMo1GCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3gx5Gr8QnllRuRQupDcHbPJTfCXuFi4j+WZkaZcl6xbbAaJlEltlmEQ83NfRXV5t
	 Uu7GR5S0fBq3emmGr9IvauKy/AjPFWv7bNGkumHlynqL4G0BbAnTWA9fhNkFQbOB0n
	 4lUZBYEcNrwe2NNqyq0HOHv+Xkg3QZmPQ8a+MocSb4GvSdM44juEDULEbQKi988dug
	 g/OvhwY/ctY38D2OeGZW4yBbYir1FCK5G00VhrZMUCZa5jY0wxRNEYn96MCEe0bCGG
	 Jy0pYWlRDtU1m72zFjl5IQbMAKsYSEL3h7Y1rPw/Cm0TTT8mlw2jgh6RYw9CUE3zlo
	 lIs6AWg7pB41g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Quadros <rogerq@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	alexander.sverdlin@gmail.com,
	dan.carpenter@linaro.org,
	npitre@baylibre.com,
	danishanwar@ti.com,
	m-malladi@ti.com,
	r-gunasekaran@ti.com,
	dmaengine@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 310/642] dmaengine: ti: k3-udma-glue: Drop skip_fdq argument from k3_udma_glue_reset_rx_chn
Date: Mon,  5 May 2025 18:08:46 -0400
Message-Id: <20250505221419.2672473-310-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Roger Quadros <rogerq@kernel.org>

[ Upstream commit 0da30874729baeb01889b0eca16cfda122687503 ]

The user of k3_udma_glue_reset_rx_chn() e.g. ti_am65_cpsw_nuss can
run on multiple platforms having different DMA architectures.
On some platforms there can be one FDQ for all flows in the RX channel
while for others there is a separate FDQ for each flow in the RX channel.

So far we have been relying on the skip_fdq argument of
k3_udma_glue_reset_rx_chn().

Instead of relying on the user to provide this information, infer it
based on DMA architecture during k3_udma_glue_request_rx_chn() and save it
in an internal flag 'single_fdq'. Use that flag at
k3_udma_glue_reset_rx_chn() to deicide if the FDQ needs
to be cleared for every flow or just for flow 0.

Fixes the below issue on ti_am65_cpsw_nuss driver on AM62-SK.

> ip link set eth1 down
> ip link set eth0 down
> ethtool -L eth0 rx 8
> ip link set eth0 up
> modprobe -r ti_am65_cpsw_nuss

[  103.045726] ------------[ cut here ]------------
[  103.050505] k3_knav_desc_pool size 512000 != avail 64000
[  103.050703] WARNING: CPU: 1 PID: 450 at drivers/net/ethernet/ti/k3-cppi-desc-pool.c:33 k3_cppi_desc_pool_destroy+0xa0/0xa8 [k3_cppi_desc_pool]
[  103.068810] Modules linked in: ti_am65_cpsw_nuss(-) k3_cppi_desc_pool snd_soc_hdmi_codec crct10dif_ce snd_soc_simple_card snd_soc_simple_card_utils display_connector rtc_ti_k3 k3_j72xx_bandgap tidss drm_client_lib snd_soc_davinci_mcas
p drm_dma_helper tps6598x phylink snd_soc_ti_udma rti_wdt drm_display_helper snd_soc_tlv320aic3x_i2c typec at24 phy_gmii_sel snd_soc_ti_edma snd_soc_tlv320aic3x sii902x snd_soc_ti_sdma sa2ul omap_mailbox drm_kms_helper authenc cfg80211 r
fkill fuse drm drm_panel_orientation_quirks backlight ip_tables x_tables ipv6 [last unloaded: k3_cppi_desc_pool]
[  103.119950] CPU: 1 UID: 0 PID: 450 Comm: modprobe Not tainted 6.13.0-rc7-00001-g9c5e3435fa66 #1011
[  103.119968] Hardware name: Texas Instruments AM625 SK (DT)
[  103.119974] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  103.119983] pc : k3_cppi_desc_pool_destroy+0xa0/0xa8 [k3_cppi_desc_pool]
[  103.148007] lr : k3_cppi_desc_pool_destroy+0xa0/0xa8 [k3_cppi_desc_pool]
[  103.154709] sp : ffff8000826ebbc0
[  103.158015] x29: ffff8000826ebbc0 x28: ffff0000090b6300 x27: 0000000000000000
[  103.165145] x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000019df6b0
[  103.172271] x23: ffff0000019df6b8 x22: ffff0000019df410 x21: ffff8000826ebc88
[  103.179397] x20: 000000000007d000 x19: ffff00000a3b3000 x18: 0000000000000000
[  103.186522] x17: 0000000000000000 x16: 0000000000000000 x15: 000001e8c35e1cde
[  103.193647] x14: 0000000000000396 x13: 000000000000035c x12: 0000000000000000
[  103.200772] x11: 000000000000003a x10: 00000000000009c0 x9 : ffff8000826eba20
[  103.207897] x8 : ffff0000090b6d20 x7 : ffff00007728c180 x6 : ffff00007728c100
[  103.215022] x5 : 0000000000000001 x4 : ffff000000508a50 x3 : ffff7ffff6146000
[  103.222147] x2 : 0000000000000000 x1 : e300b4173ee6b200 x0 : 0000000000000000
[  103.229274] Call trace:
[  103.231714]  k3_cppi_desc_pool_destroy+0xa0/0xa8 [k3_cppi_desc_pool] (P)
[  103.238408]  am65_cpsw_nuss_free_rx_chns+0x28/0x4c [ti_am65_cpsw_nuss]
[  103.244942]  devm_action_release+0x14/0x20
[  103.249040]  release_nodes+0x3c/0x68
[  103.252610]  devres_release_all+0x8c/0xdc
[  103.256614]  device_unbind_cleanup+0x18/0x60
[  103.260876]  device_release_driver_internal+0xf8/0x178
[  103.266004]  driver_detach+0x50/0x9c
[  103.269571]  bus_remove_driver+0x6c/0xbc
[  103.273485]  driver_unregister+0x30/0x60
[  103.277401]  platform_driver_unregister+0x14/0x20
[  103.282096]  am65_cpsw_nuss_driver_exit+0x18/0xff4 [ti_am65_cpsw_nuss]
[  103.288620]  __arm64_sys_delete_module+0x17c/0x25c
[  103.293404]  invoke_syscall+0x44/0x100
[  103.297149]  el0_svc_common.constprop.0+0xc0/0xe0
[  103.301845]  do_el0_svc+0x1c/0x28
[  103.305155]  el0_svc+0x28/0x98
[  103.308207]  el0t_64_sync_handler+0xc8/0xcc
[  103.312384]  el0t_64_sync+0x198/0x19c
[  103.316040] ---[ end trace 0000000000000000 ]---

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/20250224-k3-udma-glue-single-fdq-v2-1-cbe7621f2507@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/k3-udma-glue.c                | 15 +++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.c     |  4 ++--
 drivers/net/ethernet/ti/icssg/icssg_common.c |  2 +-
 include/linux/dma/k3-udma-glue.h             |  3 +--
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 7c224c3ab7a07..f87d244cc2d67 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -84,6 +84,7 @@ struct k3_udma_glue_rx_channel {
 	struct k3_udma_glue_rx_flow *flows;
 	u32 flow_num;
 	u32 flows_ready;
+	bool single_fdq;	/* one FDQ for all flows */
 };
 
 static void k3_udma_chan_dev_release(struct device *dev)
@@ -970,10 +971,13 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 
 	ep_cfg = rx_chn->common.ep_config;
 
-	if (xudma_is_pktdma(rx_chn->common.udmax))
+	if (xudma_is_pktdma(rx_chn->common.udmax)) {
 		rx_chn->udma_rchan_id = ep_cfg->mapped_channel_id;
-	else
+		rx_chn->single_fdq = false;
+	} else {
 		rx_chn->udma_rchan_id = -1;
+		rx_chn->single_fdq = true;
+	}
 
 	/* request and cfg UDMAP RX channel */
 	rx_chn->udma_rchanx = xudma_rchan_get(rx_chn->common.udmax,
@@ -1103,6 +1107,9 @@ k3_udma_glue_request_remote_rx_chn_common(struct k3_udma_glue_rx_channel *rx_chn
 		rx_chn->common.chan_dev.dma_coherent = true;
 		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
 					     DMA_BIT_MASK(48));
+		rx_chn->single_fdq = false;
+	} else {
+		rx_chn->single_fdq = true;
 	}
 
 	ret = k3_udma_glue_allocate_rx_flows(rx_chn, cfg);
@@ -1453,7 +1460,7 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_tdown_rx_chn);
 
 void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 		u32 flow_num, void *data,
-		void (*cleanup)(void *data, dma_addr_t desc_dma), bool skip_fdq)
+		void (*cleanup)(void *data, dma_addr_t desc_dma))
 {
 	struct k3_udma_glue_rx_flow *flow = &rx_chn->flows[flow_num];
 	struct device *dev = rx_chn->common.dev;
@@ -1465,7 +1472,7 @@ void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 	dev_dbg(dev, "RX reset flow %u occ_rx %u\n", flow_num, occ_rx);
 
 	/* Skip RX FDQ in case one FDQ is used for the set of flows */
-	if (skip_fdq)
+	if (rx_chn->single_fdq && flow_num)
 		goto do_reset;
 
 	/*
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index afe8127fd32be..cac67babe4559 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -515,7 +515,7 @@ static void am65_cpsw_destroy_rxq(struct am65_cpsw_common *common, int id)
 	napi_disable(&flow->napi_rx);
 	hrtimer_cancel(&flow->rx_hrtimer);
 	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, id, rx_chn,
-				  am65_cpsw_nuss_rx_cleanup, !!id);
+				  am65_cpsw_nuss_rx_cleanup);
 
 	for (port = 0; port < common->port_num; port++) {
 		if (!common->ports[port].ndev)
@@ -3433,7 +3433,7 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 	for (i = 0; i < common->rx_ch_num_flows; i++)
 		k3_udma_glue_reset_rx_chn(rx_chan->rx_chn, i,
 					  rx_chan,
-					  am65_cpsw_nuss_rx_cleanup, !!i);
+					  am65_cpsw_nuss_rx_cleanup);
 
 	k3_udma_glue_disable_rx_chn(rx_chan->rx_chn);
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 74f0f200a89d4..62065416e8861 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -955,7 +955,7 @@ void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 
 	for (i = 0; i < num_flows; i++)
 		k3_udma_glue_reset_rx_chn(chn->rx_chn, i, chn,
-					  prueth_rx_cleanup, !!i);
+					  prueth_rx_cleanup);
 	if (disable)
 		k3_udma_glue_disable_rx_chn(chn->rx_chn);
 }
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index 2dea217629d0a..5d43881e6fb77 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -138,8 +138,7 @@ int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
 			    u32 flow_num);
 void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 		u32 flow_num, void *data,
-		void (*cleanup)(void *data, dma_addr_t desc_dma),
-		bool skip_fdq);
+		void (*cleanup)(void *data, dma_addr_t desc_dma));
 int k3_udma_glue_rx_flow_enable(struct k3_udma_glue_rx_channel *rx_chn,
 				u32 flow_idx);
 int k3_udma_glue_rx_flow_disable(struct k3_udma_glue_rx_channel *rx_chn,
-- 
2.39.5



Return-Path: <dmaengine+bounces-4573-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED4A422AC
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 15:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475763ADD52
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9D6253F0C;
	Mon, 24 Feb 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twFOJMVq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A212512D2;
	Mon, 24 Feb 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405865; cv=none; b=XN+aGo0gqnwFAhk3jDyQr6NY/P8QpHEgw46LCRkr0f3N9L/H7ZnAjjhmW6pmfR21yufU/kil+icsLlL4q7w0A4Dny+axtY+b3Rfb0zNHrD7mOeeXqzW9uaYbhdl+fwhkFK0c0gyltmR5kvAfyQrZB66hnO6PCg5J9N8KwxNOLRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405865; c=relaxed/simple;
	bh=RXW/ZqUOQYh3ddriGjB0hHXuPMRg08vkWdJ+G3tf8Y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lkvT7TkEe5u0TsfDYd3HYHX2CX02DpodSXOKVQWFQ9kzg0wVY74P2d26eueytxpCGw7m6AkUndkjTIDyFc/Gg0/+Md7+wvZlNa5p5mDeN9pDjeJlAc2DaMfJAB2q0C8Czeirt95d3mnqLYTWurWwCnwWTeLGHiHtVEsiKo+9B/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twFOJMVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB72C4CEE9;
	Mon, 24 Feb 2025 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405864;
	bh=RXW/ZqUOQYh3ddriGjB0hHXuPMRg08vkWdJ+G3tf8Y4=;
	h=From:Date:Subject:To:Cc:From;
	b=twFOJMVqdEv5QVyeDoKMweZN6mRyubp9DagLsKOnb+9z3smFvnM8yv1IG8E3cTGDh
	 ffkYJWEEyF8uLOrAXVXItgqKljOY5Wj7gyiMti7IXly37KyySivjZgVxd1L8IvBWnY
	 p1bc3V6qjlzWLl5p4vFI3tt7e4sjTNWufMwSfce1ttbI0dahCRL9wJbYPg40vjz4iH
	 Vd6NaqKImLxcKSaYMDshe2h/qfI/en/Umv8J43WmQ5nHS9cP/DTdfQeOJxQMzlur8N
	 74cQBR3TjcOOMaaNmrHjWLiZsqTGJizz6YULfzYTJTRDmz6UfBkGtW8jVpPXgIzrj7
	 K8wRPOLxEYwLA==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 24 Feb 2025 16:04:17 +0200
Subject: [PATCH v2] dmaengine: ti: k3-udma-glue: Drop skip_fdq argument
 from k3_udma_glue_reset_rx_chn
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-k3-udma-glue-single-fdq-v2-1-cbe7621f2507@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGB8vGcC/4WNQQ6CMBBFr0Jm7ZiWWoiuvIdhUehQJmDRVoiG9
 O5WLuDyveS/v0GkwBThUmwQaOXIs89QHgroBuMdIdvMUIpSCykrHBUu9m7QTQthZO8mwt4+sTO
 taPVJy7rXkNePQD2/9/KtyTxwfM3hsx+t8mf/N1eJEo2wVCtSlTqL60jB03Scg4MmpfQFBACwY
 78AAAA=
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 MD Danish Anwar <danishanwar@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: srk@ti.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9147; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=RXW/ZqUOQYh3ddriGjB0hHXuPMRg08vkWdJ+G3tf8Y4=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnvHxkkQdvyAX77vJ/a7sVrxyWK6821R2zdC697
 VqHbXsMlM2JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ7x8ZAAKCRDSWmvTvnYw
 k/pID/9FSlGfkZ6vilty0fgHJK8vVS2uSqpDVjzQCnB8TQkV++dO38zDtkRpfCFSxHGCAlszPcy
 rmFNyiRJzdt3Mx+sr7VE8bUToW3Oxm6oBa7AQeuaud/eE/3DIzyd4W2jMrzUsu9glB1Ij/Qvuk4
 1NwO84x+YuNP65OH0N4MnquaIBmK6vZE4mfZSHb4HsS1rM5aoDr8WjtH1c4hoQu5FAc0TpB1zdp
 mGQPX3Fyk/14NX0pleLIOfoWBMzt97Jqwkd2hy1+D3CuXIMWWD0B/8FgZtJJeTavHhEPS/JVxXg
 j7KaCE4gERbPgl1cgTbvzUsu9GSx3pk4vICbARGZAEBOiRKolxgoRn7w9wpXl1ImfeVue0t02Rr
 rmR2py5yiGutuXdNReHqcypjFDV27GkGc5Qz/DnHr5SkcDnr4r/E9poHftKUGI9900TGhH77Mdj
 n7Fyh/Sexj6HRkoDwpKKiT9MPw8P1K2h1XLwGW5MzHraQ3wD+Qs4Y6W7RQaId8d7AZdZIRHyx8V
 /7WOix7fRKJar/BE6iU2rDR6odflaygeKisGtfs/k3+J0dAUaqJDmqszs7TVEKqRyYn2wx6XfYa
 o2+sV9BVMtCxtTzxnA9ibNKR3ZTwo1qUDt0jR7wk30bsjnBonxLZB+iq99pYsGMOEN1EIXTbv57
 9f5vq1VkNthWH3w==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

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
---
Changes in v2:
- Rebased on dmaengine/testing
- Added Acked-by tags from Jakub and Peter.
- Link to v1: https://lore.kernel.org/r/20250116-k3-udma-glue-single-fdq-v1-1-a0de73e36390@kernel.org
---
 drivers/dma/ti/k3-udma-glue.c                | 15 +++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.c     |  4 ++--
 drivers/net/ethernet/ti/icssg/icssg_common.c |  2 +-
 include/linux/dma/k3-udma-glue.h             |  3 +--
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 7c224c3ab7a0..f87d244cc2d6 100644
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
index b663271e79f7..a1a482ca955f 100644
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
@@ -3406,7 +3406,7 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 	for (i = 0; i < common->rx_ch_num_flows; i++)
 		k3_udma_glue_reset_rx_chn(rx_chan->rx_chn, i,
 					  rx_chan,
-					  am65_cpsw_nuss_rx_cleanup, !!i);
+					  am65_cpsw_nuss_rx_cleanup);
 
 	k3_udma_glue_disable_rx_chn(rx_chan->rx_chn);
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 74f0f200a89d..62065416e886 100644
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
index 2dea217629d0..5d43881e6fb7 100644
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

---
base-commit: 76ed9b7d177ed5aa161a824ea857619b88542de1
change-id: 20250116-k3-udma-glue-single-fdq-cab0b54517f5

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>



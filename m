Return-Path: <dmaengine+bounces-428-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5576380AF69
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 23:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872971C20A34
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 22:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE465915B;
	Fri,  8 Dec 2023 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="hmh5AfGb"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5C21706;
	Fri,  8 Dec 2023 14:08:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id A745B2D00FCF;
	Fri,  8 Dec 2023 23:08:11 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Pm6PtbYcO1Xs; Fri,  8 Dec 2023 23:08:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id C4CD72D00FCE;
	Fri,  8 Dec 2023 23:08:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl C4CD72D00FCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702073290;
	bh=OqUf+5qMMYkf8m8dTkgiVgao04lPLCwTYIySk9A5NlY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=hmh5AfGbadyV6Y1sJdDJrvt+W6zrZhbGalxGYhz2woEeVgmT2A07pu1h8vdmYqZ4W
	 sRQi+4cS3MzIPU47Qf5b6X6gZNCspXKZwsnsR4IIVR1Ay1iyfKJhye3L0b43mfWs7e
	 UxHq3pLclgpbCv8riGhpNy3vggV8BHfKrMYVFeoj4mC+OzRNlQI73niTlklqH1HUv0
	 r4ediBNW66UcvTEeptVuH2MfE9jcK380BB2RQ7tIrdbLB/UAAJF2gksfvVB1ZhJeoO
	 27vjQpKdEzlCjC/I+ifMu5dav66kFCQwmvCJPzIzqQL1gcZ2xTWsiahTZ3beI/M9/H
	 Leaq6fG5B1YmQ==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fAPQKYUSh1JW; Fri,  8 Dec 2023 23:08:10 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.6])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 249152D00FCC;
	Fri,  8 Dec 2023 23:08:10 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com
Cc: jankul@alatek.krakow.pl
Subject: [FIXED PATCH v4 6/8] dmaengine: xilinx: xdma: Add transfer error reporting
Date: Fri,  8 Dec 2023 23:08:02 +0100
Message-Id: <20231208220802.56458-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9d683987-53db-a53e-9215-3a29f0167183@amd.com>
References: <9d683987-53db-a53e-9215-3a29f0167183@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Extend the capability of transfer status reporting. Introduce error flag,
which allows to report error in case of a interrupt-reported error
condition.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index d1bc36133a45..a7cd378b7e9a 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -85,6 +85,7 @@ struct xdma_chan {
  * @cyclic: Cyclic transfer vs. scatter-gather
  * @periods: Number of periods in the cyclic transfer
  * @period_size: Size of a period in bytes in cyclic transfers
+ * @error: tx error flag
  */
 struct xdma_desc {
 	struct virt_dma_desc		vdesc;
@@ -97,6 +98,7 @@ struct xdma_desc {
 	bool				cyclic;
 	u32				periods;
 	u32				period_size;
+	bool				error;
 };

 #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
@@ -274,6 +276,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num,=
 bool cyclic)
 	sw_desc->chan =3D chan;
 	sw_desc->desc_num =3D desc_num;
 	sw_desc->cyclic =3D cyclic;
+	sw_desc->error =3D false;
 	dblk_num =3D DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
 	sw_desc->desc_blocks =3D kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks=
),
 				       GFP_NOWAIT);
@@ -770,20 +773,20 @@ static enum dma_status xdma_tx_status(struct dma_ch=
an *chan, dma_cookie_t cookie
 	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);

 	vd =3D vchan_find_desc(&xdma_chan->vchan, cookie);
-	if (vd)
-		desc =3D to_xdma_desc(vd);
-	if (!desc || !desc->cyclic) {
-		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
-		return ret;
-	}
-
-	period_idx =3D desc->completed_desc_num % desc->periods;
-	residue =3D (desc->periods - period_idx) * desc->period_size;
+	if (!vd)
+		goto out;

+	desc =3D to_xdma_desc(vd);
+	if (desc->error) {
+		ret =3D DMA_ERROR;
+	} else if (desc->cyclic) {
+		period_idx =3D desc->completed_desc_num % desc->periods;
+		residue =3D (desc->periods - period_idx) * desc->period_size;
+		dma_set_residue(state, residue);
+	}
+out:
 	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);

-	dma_set_residue(state, residue);
-
 	return ret;
 }

@@ -820,6 +823,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *de=
v_id)
 	st &=3D XDMA_CHAN_STATUS_MASK;
 	if ((st & XDMA_CHAN_ERROR_MASK) ||
 		!(st & (CHAN_CTRL_IE_DESC_COMPLETED | CHAN_CTRL_IE_DESC_STOPPED))) {
+		desc->error =3D true;
 		xdma_err(xdev, "channel error, status register value: 0x%x", st);
 		goto out;
 	}
--
2.34.1



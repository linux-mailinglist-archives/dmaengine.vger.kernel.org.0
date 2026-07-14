Return-Path: <dmaengine+bounces-12491-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T1X0Ib4oVmpZ0QAAu9opvQ
	(envelope-from <dmaengine+bounces-12491-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:17:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8909754657
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:17:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12491-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12491-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=qualcomm.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 922FF3048DB6
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB05439A808;
	Tue, 14 Jul 2026 12:09:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26027390C9A;
	Tue, 14 Jul 2026 12:09:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030942; cv=none; b=M+xblS500C4c5nYCTWq9a7WOatMmBEabsRQpnGHYNhiplmFLGDAfl2Qr1IJh7kdoMYHTxfMLgEmACfJSJnOgnJYuUrRdrOcWGgooU0KM3GHNcqFBqaCqUk0Mui7o+7Q0wK+ZJGgTvrZBlqk47QTlKxxaKvKTC+rqsO5n2ji0YZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030942; c=relaxed/simple;
	bh=DoH7hPNg0fHxC+lCNJKTY0zrXTBD6EGE6jTVdxWvpPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFwaKw+rTsSP0KAQRDO6hyyJToCKfWKAokIAIq9rQxmbdbkcpiXHLnJ10DY1d7IxthexNUsLFGgFPJ2y2HZLzcOySYAVAMQpus+FxpxKcJxW9FJPHMTXFPAov4O68GwIXJSCFvaKuQUdGUgFqWTdV9zaR5uiBG0IKFqqWA0xLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1859D1F000E9;
	Tue, 14 Jul 2026 12:08:56 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 14:08:33 +0200
Subject: [PATCH v2 2/3] bus: mhi: ep: Add mhi_cntrl->flush_async() callback
 to flush the async read/write
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-mhi-ep-flush-v2-2-b6a9db011e85@oss.qualcomm.com>
References: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
In-Reply-To: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3321;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=DoH7hPNg0fHxC+lCNJKTY0zrXTBD6EGE6jTVdxWvpPg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqVibPwrOb4UYlQc3nLzYN/rTvy06oXd6q/uuUU
 lv9p3g4Vl2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCalYmzwAKCRBVnxHm/pHO
 9bGWB/9ajfMPV4GSG3rHDRUogdaSu/zlpYJSOm0A49KP4UbNIa9y44rUsHZfNjrgRLYF25D3HmJ
 1nwF+maOh8NajFu+JH8MC/y4kdbB0wTR6WUunVdB+0yqLPDQ9xc+AxdxKI4/9rDA/r0ssN2/DSZ
 q56Vqt97yfDZ58f6fXVeLRG0yFKfUU93I84oxNYf6vtsMCMSKi+nHCbNUdtrABs+UEyL6+IaG0h
 /CvNAd30guZewPV1JvS+v3HPsfpf4ZjJFiKfcLhLeXnLPCeqkvx7DwsgAeHKUTFsgioKIWX9SVA
 5+SJINYyDaZvkdjbTA9zAUp8VcyNE7SencCIF4N/VXDTUPBX
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[qualcomm.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:stable+noautosel@kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[manivannan.sadhasivam@oss.qualcomm.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-12491-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,dmaengine@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,noautosel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8909754657

MHI EP stack makes use of the MHI controller drivers like MHI EPF to do
read/write to the host memory. And that driver is free to use mechanisms
like DMA to offload the read/write operations.

So if DMA is used for offload, then there is no guarantee that those DMA
operations would be completed by the time mhi_ep_remove() gets called. This
can lead to UAF (Use-After-Free) issues as the DMA callback can trigger
xfer_cb() even after mhi_ep_remove() has returned.

So to fix this issue, introduce the mhi_cntrl->flush_async() callback and
call it in mhi_ep_remove() before setting xfer_cb to NULL.

Note that flush_async() blocks until all the in-flight async transfers are
completed, so calling it with the chan->lock held would needlessly stall
the transfer paths on that channel for the whole duration of the drain. So
drop chan->lock around the flush and clear xfer_cb() only afterwards, once
all the pending completions are drained.

Cc: <stable+noautosel@kernel.org> # Needs dmaengine driver fix as well
Fixes: 2547beb00ddb ("bus: mhi: ep: Add support for async DMA read operation")
Fixes: ee08acb58fe4 ("bus: mhi: ep: Add support for async DMA write operation")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bus/mhi/ep/main.c | 7 +++++++
 include/linux/mhi_ep.h    | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 0277e1ab1198..329a4855d397 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1612,6 +1612,7 @@ static void mhi_ep_remove(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
 	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
+	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
 	struct mhi_result result = {};
 	struct mhi_ep_chan *mhi_chan;
 	int dir;
@@ -1636,6 +1637,12 @@ static void mhi_ep_remove(struct device *dev)
 		}
 
 		mhi_chan->state = MHI_CH_STATE_DISABLED;
+		mutex_unlock(&mhi_chan->lock);
+
+		if (mhi_cntrl->flush_async)
+			mhi_cntrl->flush_async(mhi_cntrl);
+
+		mutex_lock(&mhi_chan->lock);
 		mhi_chan->xfer_cb = NULL;
 		mutex_unlock(&mhi_chan->lock);
 	}
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 7b40fc8cbe77..f6383a57a872 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -107,6 +107,7 @@ struct mhi_ep_buf_info {
  * @write_sync: CB function for writing to host memory synchronously
  * @read_async: CB function for reading from host memory asynchronously
  * @write_async: CB function for writing to host memory asynchronously
+ * @flush_async: CB function for flushing asynchronous read/writes
  * @mhi_state: MHI Endpoint state
  * @max_chan: Maximum channels supported by the endpoint controller
  * @mru: MRU (Maximum Receive Unit) value of the endpoint controller
@@ -164,6 +165,7 @@ struct mhi_ep_cntrl {
 	int (*write_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 	int (*read_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 	int (*write_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
+	void (*flush_async)(struct mhi_ep_cntrl *mhi_cntrl);
 
 	enum mhi_state mhi_state;
 

-- 
2.43.0



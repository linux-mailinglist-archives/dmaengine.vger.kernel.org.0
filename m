Return-Path: <dmaengine+bounces-11833-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMYXFcwwQmob1gkAu9opvQ
	(envelope-from <dmaengine+bounces-11833-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:46:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC36D7A1E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:46:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=HcZ8Ukvz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11833-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11833-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D87130305D2
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123A3F8705;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463E3F825F;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722723; cv=none; b=amVIFXA+xWEb5rJtctR6BofIF+THZDN1/fCVVtpX4cognlYMKutyHB4Ex99tIZpUD3M8NEJ8SimJQmWwUnF8ncPZ7EeQh1qZehYt5QytLr1LqVQWInsKxwHAOpu605fcXa+agFLh4+REjbp+BS6OKLBClJTIq3d80E+bQyjQdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722723; c=relaxed/simple;
	bh=qj82EtDuBeYVneJ3FxQ5RIXlt/hf3RFw2DTqHgNPMEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahIDqWhnZDWkLnQGs2n7fERBnK34tBmqyx+2WvIZSkbV2TDvoC1SC2wNoj18r1wvxFjvwPdfbQ6r3w5HeVIu31oH8077CA/t9MKzWwB5gSQAQzEoI9DsAbSNU9YgPQHwNbNwaAOQV1MvQeyuoYIwrduqWMQ+iwAGNrcUawsaLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcZ8Ukvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 306C1C2BCFA;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782722723;
	bh=qj82EtDuBeYVneJ3FxQ5RIXlt/hf3RFw2DTqHgNPMEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HcZ8UkvzIcRVJgI8HgwMlvHXElC6GrvXHELyf8dkQBCk6BskGrRZYNpbFnUjcOE+A
	 cH2g96/ziQdflps5HuDzoB2nZhnooHynzHJiBVoGqw2T5YMyZs+TbLEJ0l/kBJqJGJ
	 lUGPX/HSLu00k9nYrH6+mIjHiWoxEBLUibHl7y8HvtT14mWKNRMJykoJDkFWt2XkYG
	 oVRDvV8KSTNq9II94lu3kB4ukxd09tklXSYSYWhSDJPd6RpkEE9HdFH3dvzInWX+sR
	 0XjCLHSya/mF1VBaacsxg7gifn5xip/lKMUpPXS4Z1cqFr4FwVC21QlbkgZe+jd68Q
	 skrd8LQA3p0TQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D2C43638;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 29 Jun 2026 10:45:16 +0200
Subject: [PATCH 2/3] bus: mhi: ep: Add mhi_cntrl->flush_async() callback to
 flush the async read/write
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-mhi-ep-flush-v1-2-714e0d56e87c@oss.qualcomm.com>
References: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
In-Reply-To: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqQjCgCNY3QvJvJ3yi452OlMzvaFYQkyelWNvE2
 wmHLWypum2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCakIwoAAKCRBVnxHm/pHO
 9ZcxB/sEO2M7/DGIBby1khnchghmcOOW+znPZqa3/ba+LaIW//D5fMczex/cU9+nrl1Pk0oOQ4f
 2/zx3Hlw/8FUXc/NE/tXEnS0+mdmyxgwo00QwPiB7ZfFoAVSx+e48LVXLTeuG5+6EjaF0zxAUVb
 urbcc6zLiIBM81spRUYFR/CqYsBxgT1bFhL+IAcIMf4f+RUMjLmUga7059uQsMP1e6hJgshj4ez
 4EXsZZ9B1A4W+iHJc9ZZqLsl7AkkKGFZWkLHHgwfcQ8mX0izqLfSMTBj6N7m6wEXPXWriNhkR2l
 gGNJ+bMxHHy8qWCjOuC7zf0ADAchZ1UyBOsRZNER4RmXIrzf
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11833-lists,dmaengine=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:stable+noautosel@kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,noautosel];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,oss.qualcomm.com:replyto,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9DC36D7A1E

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

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




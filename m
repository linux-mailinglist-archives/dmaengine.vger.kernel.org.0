Return-Path: <dmaengine+bounces-2190-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C898D1434
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 08:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A72B21F13
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6482151012;
	Tue, 28 May 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cboUSiem"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364844F5FD;
	Tue, 28 May 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876565; cv=none; b=WEJYYxlPbRGwXKIn3VzAslFqMu/d6NM8gb3gqAPNicym7v203S/34KPcIEvncmQlTRJS1UB9Dz8chEZeWQpxpgQ1fpyEIApNEYdqBKZaRaiWIz+PJu6zDH2ul1yfQEOmAC3FYINNvRRvSRJrCNv3ZCZwUKfVXD25+NtGqdmc8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876565; c=relaxed/simple;
	bh=Eqtg8XNRPOkiV1rBmKE+E5Q17RJH/f6pOWXblhQp/oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOiFOhzQLmTz/gVXxh9IlcNu8lwY6+KjiWFsR18+Iocz4Zahl/uFtQMwIb+2w2UxlbtvPh0uWMLWJ5nlSdtJqVHzAXnEthOAN7/J5cuK0IXLyvetVbaDbVGqwK2hfCpN8dRngTdp1vPTKJdBkqlgj+rVX4B4vQMibmxcCMwModM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cboUSiem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA425C4AF09;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716876564;
	bh=Eqtg8XNRPOkiV1rBmKE+E5Q17RJH/f6pOWXblhQp/oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cboUSiem9KklcZFiXMPFFmoO869Fn7z+mlCVUx/tp3HK+Cc8XrMH4rm3LyJvhATSp
	 4dtV2YL/W+SLRTPu/QjGlCQ8wmPW/nG+SayWvkYKAfj09bf7u7f33jl1e/zZ4fW10n
	 FjLsQgQjwD8Cr/vIuyUt4jvW2topU7rlEXY5iFFgUXkxPpgcch2RDdoiTwUvtnGS3I
	 c4ZL0FYsG1sOzHVVd3Ocu6jeNOrYOyAotBTfFrmrxRHEnN5KLMEWBVlUmwhq3YQgPY
	 mdM6iXghB9TgsCtph4dy/5nkm0a+NDVkSmo3g4Fs8L9j2P+rStSgJLvT3bYz5Q89uJ
	 IT9WQZ58h+lfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FE0C27C4E;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Tue, 28 May 2024 09:09:25 +0300
Subject: [PATCH v2 3/3] dmaengine: ioatdma: Fix kmemleak in
 ioat_pci_probe()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-ioatdma-fixes-v2-3-a9f2fbe26ab1@yadro.com>
References: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
In-Reply-To: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Logan Gunthorpe <logang@deltatee.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@yadro.com, 
 Nikita Shubin <n.shubin@yadro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716876563; l=1823;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=tibFMcaMMDINAMULT2DBvxJYeYcAsWOCGa6cDYv40uU=;
 b=Spd8wOljNfdMMhAzdRsBkqUw7Og0HFDv9oagQ2CV4x/zau+jRsHiHjlwwnYJMz6jjFm38Gzeif5N
 xvJJmEOnDPT6u6tYxvot0aqRUcWdbEYraI1TO2qjxXOxk6eLRGxh
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

From: Nikita Shubin <n.shubin@yadro.com>

If probing fails we end up with leaking ioatdma_device and each
allocated channel.

Following kmemleak easy to reproduce by injecting an error in
ioat_alloc_chan_resources() when doing ioat_dma_self_test().

unreferenced object 0xffff888014ad5800 (size 1024): [..]
    [<ffffffff827692ca>] kmemleak_alloc+0x4a/0x80
    [<ffffffff81430600>] kmalloc_trace+0x270/0x2f0
    [<ffffffffa000b7d1>] ioat_pci_probe+0xc1/0x1c0 [ioatdma]
[..]

repeated for each ioatdma channel:

unreferenced object 0xffff8880148e5c00 (size 512): [..]
    [<ffffffff827692ca>] kmemleak_alloc+0x4a/0x80
    [<ffffffff81430600>] kmalloc_trace+0x270/0x2f0
    [<ffffffffa0009641>] ioat_enumerate_channels+0x101/0x2d0 [ioatdma]
    [<ffffffffa000b266>] ioat3_dma_probe+0x4d6/0x970 [ioatdma]
    [<ffffffffa000b891>] ioat_pci_probe+0x181/0x1c0 [ioatdma]
[..]

Fixes: bf453a0a18b2 ("dmaengine: ioat: Support in-use unbind")
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 drivers/dma/ioat/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 26964b7c8cf1..cf688b0c8444 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1347,6 +1347,7 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	void __iomem * const *iomap;
 	struct device *dev = &pdev->dev;
 	struct ioatdma_device *device;
+	unsigned int i;
 	u8 version;
 	int err;
 
@@ -1384,6 +1385,9 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	err = ioat3_dma_probe(device, ioat_dca_enabled);
 	if (err) {
+		for (i = 0; i < IOAT_MAX_CHANS; i++)
+			kfree(device->idx[i]);
+		kfree(device);
 		dev_err(dev, "Intel(R) I/OAT DMA Engine init failed\n");
 		return -ENODEV;
 	}

-- 
2.43.2




Return-Path: <dmaengine+bounces-11479-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hq7qBSskK2rM3AMAu9opvQ
	(envelope-from <dmaengine+bounces-11479-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:10:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7496C675615
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:10:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WK9Exm8l;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11479-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11479-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0F153342703
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754953803FD;
	Thu, 11 Jun 2026 21:07:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36237B402
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:07:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212070; cv=none; b=dfcThaoKQYL0Wpyq/vGaMncyA5F3i+lgUh3/oiud2sykhlh1Yq/edvXd+XIoRYVR4VFbbzUUpX7iwyIDx3q/ghWvdlFVRt6Wq7dLizTmD6nfq9/pkG9bwgsK4dWu6COs6d11kHpznSzzUd9OG86JNRUPXU5UeyyrblsOQ7W0Ic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212070; c=relaxed/simple;
	bh=5JoLRCeu+E2PnWKzUKkkD/JB9XvHf6wbdyGdGBkGj7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6zmVigIZV40qO9JKBUVVSQctkccCzqvAj1E+ZDplLdgN83zvWGvwIr2pPZ+vAsvDqpcDMwnxRFneSDOL0zz4JwQ+qQ24g0qOjnKbRZd9/FjVV9owGVRVjlqhfUUgB5oCbq9ums1tHcUq3vKApJrxj4Z56pm5TjsE0j7e0H6T5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK9Exm8l; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf22d29dabso2114825ad.2
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781212065; x=1781816865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIlS0gTD7wW7yJLvROv1DCGaq5p/ibohnBpYCwWAhP0=;
        b=WK9Exm8ltscuND5mmJYCYRlpUyKVFFMyVR6JYP2ZYBBlRTQ9G2Q7mojPIw8QjKvh5l
         0FSxHFfYLnXRLa6+moUcXYdrEAYaF6+/jV063zKQRkMkiwROhRJR/swUXvsH1WrfKOaj
         TEILqwZPLAKou5a4LDV6I/I8C8jAriTckp0D+wJU6aKgkuh0SmDW6MQxICnvrhRvwgWt
         Czw9rniTLqufzvPimkzN7ETRYiU//++UyyZILq9P18eOHyNYZurgtlm9G3MkTUlpdL8+
         6SQLd2u7NEJGySGwOYHRPriEzYYOj8JlLOYcUvIHB2/wjORA1zHTrJR5UMUonxqBKa1P
         zosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212065; x=1781816865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GIlS0gTD7wW7yJLvROv1DCGaq5p/ibohnBpYCwWAhP0=;
        b=tQGiPBmifWqa8hZ3yQDBeAxJZDB12FoKBw8A5/FxqlKpj0Vagcnolml4L3P5D6OCt/
         ujs9lFJj50/FSC/3aIpaXiV40aKGVow9uKvrodXrpY0UhDUpvUmPtMYrjybmhXqSbpG7
         LwfZHV3UBLmEnPtvUsMRC1rH4zutspXYhx2/zHqMQRn1w63jujrFUh1pp/f4RoWRhy1+
         Gyo3NypZrd0lM8dHrabrtIkyvTvzS9GzPlv9toDn9+3TQOVDiC+rshqZ2RXKNw19YYm/
         HOawZZTQKBEIwwF/JqGz9Dqo5V7dLEysGJW134EUa/GlRo3M6X6f2TYDQl1N5ITAhVum
         +O/Q==
X-Gm-Message-State: AOJu0YxrM1AMpdYJ5ODczhnwBrkM4AdeuMgc+/Jgnk9SoR/mzs2fMhE9
	IW6eUZ+DpDk6WSc+WpVYQrgjblUzQN4W8zsRXEi5lZz2sP/UDSFdX/wIOdb/Uw==
X-Gm-Gg: Acq92OHUrUFte/A5LqaU454p0qbVrgYAMbfcR2YoL8tlUCqi8cHv058VlOO6urZk9Is
	XznLK3Qw789lri9Q/psiW4SBonMN/g1mkEAx878gxOj8j2HVbOR0CseZxso1IyDyqwaYhuNaNWs
	BsCiXz49iRoieMntqbgkf2ShXYp+NRQ8kQd9vRpXauUl0P4+K1/tGLLkRW0sYKZLokqh5LMtAgu
	Giz6+9KthkgEeuZoxDqHItAqT3Z9eRxTCVzU2KIzCeT+zNZIvJ//jrSvbL78I+VEmnLJmyejLmA
	0kLqH1xaeuvolBZSG0y/r1buecZi+R+LqpbZlMFQtMFmbZ8lbf0HnzOZJfmctQHPaKsnliMOM5O
	/oIlSC39f0RkslGjvDVyZ0epd2CJMy35qAHAe5pEuE/D5vwlRTBbs+eGZrHHUKSZX2VYGfIyA5Q
	RfU0phtaM2S7QErCou3C6yV8Ha7S3yPq9prfSr1csaWxGZOy7OqRHSAxXhG7cYouoxbz42vYfbx
	00+HHSKGSYinlYDS8n/1tWxhIG0DkaCfhk=
X-Received: by 2002:a17:903:120e:b0:2be:3434:4e28 with SMTP id d9443c01a7336-2c411c79bf3mr895955ad.19.1781212065249;
        Thu, 11 Jun 2026 14:07:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6d3a:64fc:4ee8:9cc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c411d79289sm389995ad.14.2026.06.11.14.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:07:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 4/9] dmaengine: mv_xor: abort channel before freeing resources on timeout
Date: Thu, 11 Jun 2026 14:07:16 -0700
Message-ID: <20260611210721.81979-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611210721.81979-1-rosenp@gmail.com>
References: <20260611210721.81979-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11479-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thomas.petazzoni@free-electrons.com,m:gregory.clement@bootlin.com,m:mw@semihalf.com,m:robh@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7496C675615

In mv_chan_memcpy_self_test() and mv_chan_xor_self_test(), if the DMA
operation times out (status check returns !DMA_COMPLETE), the code jumps
to free_resources which unmaps DMA buffers, frees the descriptor pool,
and releases the source/destination pages without ever stopping the
hardware channel.  The DMA engine may still be executing and could DMA
into the freed destination pages, corrupting kernel memory.

Add mv_chan_disable() which masks interrupts and clears the activation
register to abort any in-flight operation.  Call it in the self-test
error paths before freeing resources, and also at the top of
mv_xor_free_chan_resources() to protect clients that release the
channel while DMA is active.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 588af337afe3..44a7d4f7fb0d 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -169,6 +169,12 @@ static void mv_chan_activate(struct mv_xor_chan *chan)
 	writel(BIT(0), XOR_ACTIVATION(chan));
 }
 
+static void mv_chan_disable(struct mv_xor_chan *chan)
+{
+	mv_chan_mask_interrupts(chan);
+	writel_relaxed(0, XOR_ACTIVATION(chan));
+}
+
 static char mv_chan_is_busy(struct mv_xor_chan *chan)
 {
 	u32 state = readl_relaxed(XOR_ACTIVATION(chan));
@@ -638,6 +644,8 @@ static void mv_xor_free_chan_resources(struct dma_chan *chan)
 	struct mv_xor_desc_slot *iter, *_iter;
 	int in_use_descs = 0;
 
+	mv_chan_disable(mv_chan);
+
 	spin_lock_bh(&mv_chan->lock);
 
 	mv_chan_slot_cleanup(mv_chan);
@@ -854,7 +862,7 @@ static int mv_chan_memcpy_self_test(struct mv_xor_chan *mv_chan)
 		dev_err(dma_chan->device->dev,
 			"Self-test copy timed out, disabling\n");
 		err = -ENODEV;
-		goto free_resources;
+		goto free_chan;
 	}
 
 	dma_sync_single_for_cpu(dma_chan->device->dev, dest_dma,
@@ -863,9 +871,11 @@ static int mv_chan_memcpy_self_test(struct mv_xor_chan *mv_chan)
 		dev_err(dma_chan->device->dev,
 			"Self-test copy failed compare, disabling\n");
 		err = -ENODEV;
-		goto free_resources;
+		goto free_chan;
 	}
 
+free_chan:
+	mv_chan_disable(mv_chan);
 free_resources:
 	dmaengine_unmap_put(unmap);
 	mv_xor_free_chan_resources(dma_chan);
@@ -987,7 +997,7 @@ mv_chan_xor_self_test(struct mv_xor_chan *mv_chan)
 		dev_err(dma_chan->device->dev,
 			"Self-test xor timed out, disabling\n");
 		err = -ENODEV;
-		goto free_resources;
+		goto free_chan;
 	}
 
 	dma_sync_single_for_cpu(dma_chan->device->dev, dest_dma,
@@ -999,10 +1009,12 @@ mv_chan_xor_self_test(struct mv_xor_chan *mv_chan)
 				"Self-test xor failed compare, disabling. index %d, data %x, expected %x\n",
 				i, ptr[i], cmp_word);
 			err = -ENODEV;
-			goto free_resources;
+			goto free_chan;
 		}
 	}
 
+free_chan:
+	mv_chan_disable(mv_chan);
 free_resources:
 	dmaengine_unmap_put(unmap);
 	mv_xor_free_chan_resources(dma_chan);
@@ -1020,6 +1032,7 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 	struct device *dev = mv_chan->dmadev.dev;
 
 	mv_chan_mask_interrupts(mv_chan);
+	mv_chan_disable(mv_chan);
 	tasklet_kill(&mv_chan->irq_tasklet);
 
 	dma_async_device_unregister(&mv_chan->dmadev);
-- 
2.54.0



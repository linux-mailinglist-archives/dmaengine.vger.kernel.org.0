Return-Path: <dmaengine+bounces-12526-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eqgVH6fIVmqtBAEAu9opvQ
	(envelope-from <dmaengine+bounces-12526-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:39:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D45AF7597AC
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:39:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fK8nKOuC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12526-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12526-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96CE330BAA01
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC041D640;
	Tue, 14 Jul 2026 23:39:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B8368D5A
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 23:38:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072341; cv=none; b=mKAOqxSL96kjacgwHdnehdz26iEiaZBm9mNHCskvGcbhYLqLFBnu59jvi7QtAB8VM/myxyTfc3+LSSgs27vwWMGBnCR1/+Ok5jDr8kHD9HUgOvV1k6OBTV2WQYIQXNzkIhYBS4tAL/mDtTC1MmlVTvvEsGp5riEdzUJ4Owe/Pdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072341; c=relaxed/simple;
	bh=yv1tuWDWJhSyiyvMNhanYGrFvbz3c1/jLUP8Tguzisk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPiqmXLTzm9GWnwcedQio402qJ4PT1f0U+RkfsqE8tm6nUZF6oSr7zBSvgOL1rQIrEXCfzYP0KWOu4Lnfks32WK9ydSbnwvE5obbUGs7f5kUtOQezRt1csLjt+l+ZJfJWtx89KSZcXYdNSvbX9HxF6XdigGP2bw3E1xn7S+s5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK8nKOuC; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2320238a91.2
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784072339; x=1784677139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MfgBILHJrY4C17rMIeQ269NwG+vZxxLm9/G2lcTQrFA=;
        b=fK8nKOuC8wdQV3hvn3F/CfePdi8VcNG3JqAiZML8HHiBSd/Q9fulcjQRM4XUmKOUAI
         Ie4D+t97BotaZTmAerTU2aA+a+X4Zx24Tfl6/UvIPaLJrQqVt4tmCOmjGPzD6SLtq9wG
         iWhbJL2VyGFwG9Vt4IXSd1G7PMlb31rl88SOpG302C59PzQBheZiaoRI8VznsN0M2sAj
         DS9ekek/d4/ttpUeJoGkG1KpBxhnSrxUp24HSN1cUO39szCJi1Y5IgYcCeb7uiCkowAX
         MtAblzM1eWsPmL7TeUQfS5FL6MvYF9F8WWPCMP1gKPyIinHHHe/zSOd+EuRQGAqUu1q9
         RE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784072339; x=1784677139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MfgBILHJrY4C17rMIeQ269NwG+vZxxLm9/G2lcTQrFA=;
        b=srodDKwzpI6hl1yirn1i7HQ/PMesDSEuytOfVyeR5GqFxQHNJHInLXer2F84dnT7wU
         LxAsDIZpf76Zk5XWj59kNt6F26tiqJy23AJXnlEr5wz3gzEV0NWftAYLOqOMpYt0U7bq
         FqzAm+cokhUhDlXFQiMStE4255Qcvs4WgHeey3AJMFfSH2WP9zazf0Pyn9qcdjXL7uRk
         NqCGNdpThqhpjLGkacFcF8Rx7ydAdCye/wZtR1fKcrLDT6b9Rgceu0qsbVCWWwpy5X06
         hZKErxWEad6W4P5ue7v+yTSSIYGJAL+sDmrc7FDA79HA+8S8ahCRtgEW36Y5jBT+cb+9
         CG3g==
X-Gm-Message-State: AOJu0YxBB+MqpmYKsMhKTXnr7rND7ofIKdFt91zc+ryD0FJLHhkegyVU
	9i5y4T/E1r1TqtN12jn8x8GqzgDFSwU0+eVncgAVPU1NGR3UWUUFCYEA4whgzw==
X-Gm-Gg: AfdE7cl5uTaFEx+vC7JfMqfLyR8EfCtEiroBQAHromLfnV5mgdKl2/yotWxSFZK5WJm
	uGIG52Teb3bgF7NwiIot1iTAL0onjQqpLLw0RDuDpDi1Nos9emhvbnxAWFdiQS16MPFwAh79mGR
	qMBBzDsqXXoIauH1DalX7e9X5Ov5qOhG38+Qgpnb/kl1x1uw43Uy3ciH6koQbs34aQ0nXCn7+fH
	9BxrDIl4hLQXMFpcamBfhtGOJLRnArssWtSsJI5Qtf21g8xO2Hf6bXKeC/bpMt5jPi9zjAhUvUX
	Hiux0AKGpNmDHjufpH7ODrZm6jgQozmcI57UQG5qD2y+ReLJfC0inehLHYk3va6kBtwLE6k9x73
	Y6UnNogiC7s/xp77ZwWFNCNHOHB/DMZOQzVubex56mvZTXsrwLGnYycQ3AHDb1wHfcsStJjUEHE
	FXOIOcdeY9PosueGKHu8fsNjI0UaCS74v6W+kQPgvX5DPnsATq4VhwTF8T+4FYz6jjdhLnnjc2C
	Z6tzJSoQP/HT7PLq59v5RlYtKUcbN5xcyk+IqM6cVcl6JY63VhP7OfBnBErsx4MLQ==
X-Received: by 2002:a17:90b:1646:b0:38d:c834:24cf with SMTP id 98e67ed59e1d1-38e2a01d044mr537748a91.23.1784072339212;
        Tue, 14 Jul 2026 16:38:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm72317509eec.20.2026.07.14.16.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:38:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] dma: fsl_raid: fix endianness of in-memory descriptor stores
Date: Tue, 14 Jul 2026 16:38:53 -0700
Message-ID: <20260714233855.870797-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714233855.870797-1-rosenp@gmail.com>
References: <20260714233855.870797-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12526-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D45AF7597AC

The descriptor structs (fsl_re_cmpnd_frame / fsl_re_hw_desc) are
in-memory but their fields are __be32, because the structures are handed
to the device as big-endian. The driver stored CPU-endian u32 values
into them directly, which is both wrong (the engine would see
byte-swapped lengths/addresses) and flagged by sparse as a base-type
mismatch.

Wrap those stores in cpu_to_be32() so the values are little->big
converted. The final-frame bit is now passed as the "final" argument of
fill_cfd_frame() (as fsl_re_prep_dma_memcpy already did) and set in CPU
order before the single cpu_to_be32() store, replacing the previous
read-modify-write of the __be32 efrl32 field.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: https://lore.kernel.org/oe-kbuild-all/202008111749.yy85rFMD%25lkp@intel.com/
Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsl_raid.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 99945845d8b5..888f55b672a5 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -242,9 +242,9 @@ static void fill_cfd_frame(struct fsl_re_cmpnd_frame *cf, u8 index,
 	u32 efrl = length & FSL_RE_CF_LENGTH_MASK;
 
 	efrl |= final << FSL_RE_CF_FINAL_SHIFT;
-	cf[index].efrl32 = efrl;
-	cf[index].addr_high = upper_32_bits(addr);
-	cf[index].addr_low = lower_32_bits(addr);
+	cf[index].efrl32 = cpu_to_be32(efrl);
+	cf[index].addr_high = cpu_to_be32(upper_32_bits(addr));
+	cf[index].addr_low = cpu_to_be32(lower_32_bits(addr));
 }
 
 static struct fsl_re_desc *fsl_re_init_desc(struct fsl_re_chan *re_chan,
@@ -256,9 +256,10 @@ static struct fsl_re_desc *fsl_re_init_desc(struct fsl_re_chan *re_chan,
 	dma_async_tx_descriptor_init(&desc->async_tx, &re_chan->chan);
 	INIT_LIST_HEAD(&desc->node);
 
-	desc->hwdesc.fmt32 = FSL_RE_FRAME_FORMAT << FSL_RE_HWDESC_FMT_SHIFT;
-	desc->hwdesc.lbea32 = upper_32_bits(paddr);
-	desc->hwdesc.addr_low = lower_32_bits(paddr);
+	desc->hwdesc.fmt32 = cpu_to_be32(FSL_RE_FRAME_FORMAT <<
+					  FSL_RE_HWDESC_FMT_SHIFT);
+	desc->hwdesc.lbea32 = cpu_to_be32(upper_32_bits(paddr));
+	desc->hwdesc.addr_low = cpu_to_be32(lower_32_bits(paddr));
 	desc->cf_addr = cf;
 	desc->cf_paddr = paddr;
 
@@ -374,11 +375,11 @@ static struct dma_async_tx_descriptor *fsl_re_prep_dma_genq(
 	for (i = 2, j = 0; j < save_src_cnt; i++, j++)
 		fill_cfd_frame(cf, i, len, src[j], 0);
 
+	/* Fill the last frame and mark it final */
 	if (cont_q)
-		fill_cfd_frame(cf, i++, len, dest, 0);
-
-	/* Setting the final bit in the last source buffer frame in CFD */
-	cf[i - 1].efrl32 |= 1 << FSL_RE_CF_FINAL_SHIFT;
+		fill_cfd_frame(cf, i, len, dest, 1);
+	else
+		fill_cfd_frame(cf, i - 1, len, src[j - 1], 1);
 
 	return &desc->async_tx;
 }
@@ -504,16 +505,16 @@ static struct dma_async_tx_descriptor *fsl_re_prep_dma_pq(
 			p[save_src_cnt + 2] = 1;
 			fill_cfd_frame(cf, i++, len, dest[0], 0);
 			fill_cfd_frame(cf, i++, len, dest[1], 0);
-			fill_cfd_frame(cf, i++, len, dest[1], 0);
+			fill_cfd_frame(cf, i++, len, dest[1], 1);
 		} else {
 			dev_err(re_chan->dev, "PQ tx continuation error!\n");
 			return NULL;
 		}
+	} else {
+		/* Mark the last source buffer frame final */
+		fill_cfd_frame(cf, i - 1, len, src[j - 1], 1);
 	}
 
-	/* Setting the final bit in the last source buffer frame in CFD */
-	cf[i - 1].efrl32 |= 1 << FSL_RE_CF_FINAL_SHIFT;
-
 	return &desc->async_tx;
 }
 
-- 
2.55.0



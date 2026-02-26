Return-Path: <dmaengine+bounces-9160-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGkjD684pWnt5wUAu9opvQ
	(envelope-from <dmaengine+bounces-9160-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 08:13:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9154E1D3B5C
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 08:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83013301829D
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E42F7AB0;
	Mon,  2 Mar 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf6VPKt9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA16430BAC
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435593; cv=none; b=GHUkkd65s2DP8Z43WEA3tdX6OUhdgky94r6kJm+4US5qhouD7i+c0RD8T/nkU6Q9bNWn1lRu0xAv44Q9RyX+Jds79Yjddlz0HPSJYfi7d65gf9VXGLb3qkREocxJExMIFXM6ILZdiH43bMMS4P0UZTdNkOrCBz+2QvR0iokyQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435593; c=relaxed/simple;
	bh=ilkeyD8qZQOpsW+Xq7gCWaAiuV38Fp1tAggTNiSYlQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mz6yyOaNbCamK47eZuVb0YTyVDQPuBE5DjO2SxjKyOGREoLzLioqTfSAa905hE4uMIufpqSuhpp01/w8wcBykZS5C67xxL0/x4Yk9mvRa2blMJrTbntvYn57Y1lnoJ36uFj1drLiRDrYBztKYatSgr2OuuTa7n3wkZoOch65fwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rf6VPKt9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1595667a12.0
        for <dmaengine@vger.kernel.org>; Sun, 01 Mar 2026 23:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772435592; x=1773040392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwUZOQ2ZJ7lWBPCWroaNir22y89SjANnXegT9KI0WTU=;
        b=Rf6VPKt99dCqZRvhejum2RMxh1Vdt1TbXcUYPHM82xFQkFeYy1/P3rG6V+akymz1VJ
         hVRp03CkIzs2w3mnQltOpCdzdoKPD+T8qeXfe3bpzv2ENPrsgk1EpMa8niVTiCnQGFpG
         aivIc7cCOU5CORYQQR+lcFpVpHOZ1ZOYoKcBc1RzFi82dMzRAldoCGe+KD3tp0ImJAeI
         b13V035fZzwB2zJaNhqJZCQ1bHvq17+NiAYFw6uLisvt2892XdTXN7Up7NwfZmpZQVF+
         7cROY/qVxWQqJPHQRzomaldrw+V+FBlLvmfhCGoiDbnSRN+uIPW0WCa0zxhDJaniY4mD
         Inrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772435592; x=1773040392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwUZOQ2ZJ7lWBPCWroaNir22y89SjANnXegT9KI0WTU=;
        b=tUbrXByXRXGv7y3OqVmZqG3Ci+J+D8aRVfVTe3k0yJLYrvwJ1TGUrZoKdcZJ6tlBaW
         Nd7MWJnL8y6v3GAGDkdOmcYgw+ajkNIfRTLfs+hKp7GL9IhccKaXnSI1KFMdnGN7pOty
         FCE60a6k60hxWV64nllV/l2+xf4WdgHoaZzA0Q38g4TRhSYt09NAqNffENqa9KLNp3AT
         Ci2ndzI7WehZztc/i6eY/+LlsEMUhU5sj6zwXBwfWuLJt68MBthsCfqZM1urrECHKsMz
         duMwQbIBNq7M5vDMYRbSxFQUQO5ujIdtzSKUpOoPeup6j0A/5AUsRGPrb5+FJXETMm9R
         mVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2vGZuuLgQErGGi2u+/vU/NmS7Q2XA7W23p+xbdCiuhjXIJHBAWofwsKBXGWl9VfIuB5az4jKfPvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEP+h4NypS5cGR/MRLNNfnaZ/zpvW0OrDQ02Ocz1Hj26TADjlb
	BOIHnZu8Yr4Qef9ITabQXa7ZG25n0vFS1vRlcECfy+jZLi/wsxibSKAy
X-Gm-Gg: ATEYQzwwhlwegfOV9Xu6jumSAMdjzGoLiu2ACbBhCT9A1puPig1ggTlfikJuvRMTCF5
	fe63HBTzuZ/nlMMdDvkTfcW8oRvqrTqv873BRLmU/f/8ZPlmBrEqC3xCyNHt9BdybM14tWGf1vb
	ZNV/T8X/egkqJ6f1WYqnITV6SATqIc6S8TRRs/rGK9uWMGvhyzPVp6RzmN0JF6MQNvSdqK8XrcT
	CTE7mOn/+dxk+nd6zUP0+MViw3XLvwbfAHS5Cab5vVG53LmRW3S3lAEYno46RiZ9HGs3LD4E32W
	t19RsloI0tqbRbRBDKo0uCUUk//RuZj3YB2FDbUv6oTJ1xgwUh1yhvMfv4sBHans85F30JS/mIQ
	C1+x965eWH005yfB3RTs4vvONTihdaYt8ntVd0j0F2t0vWwZ6nMnHKtreFbPLnkvxLXFN+O8i6s
	V4RzyTKTcURoeDiqTxIzrveKzZ
X-Received: by 2002:a17:902:ce09:b0:2ae:508d:fc33 with SMTP id d9443c01a7336-2ae508e0117mr17613475ad.43.1772435592070;
        Sun, 01 Mar 2026 23:13:12 -0800 (PST)
Received: from bsp.. ([2401:4900:52bb:cde9:66f7:69ca:84dd:3745])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae492e6901sm36069455ad.65.2026.03.01.23.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 23:13:11 -0800 (PST)
From: Rahul Navale <rahulnavale04@gmail.com>
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Rahul Navale <rahul.navale@ifm.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	michal.simek@amd.com,
	suraj.gupta2@amd.com,
	thomas.gessler@brueckmann-gmbh.de,
	radhey.shyam.pandey@amd.com,
	tomi.valkeinen@ideasonboard.com,
	rahulnavale04@gmail.com,
	marex@nabladev.com,
	marex@denx.de
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction reporting via device_caps
Date: Thu, 26 Feb 2026 13:32:48 +0530
Message-ID: <20260226080249.3632-1-rahulnavale04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	DATE_IN_PAST(1.00)[95];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9160-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rahulnavale04@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ifm.com:email,a0100000:email,a0110000:email]
X-Rspamd-Queue-Id: 9154E1D3B5C
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

Hi Folker,

>Could you confirm this from your DT?

DT for the audio AXI DMA is below. We indeed have two distinct
AXI DMA devices, each instantiated with a single fixed-direction channel:

  axi_dma0: MM2S-only (playback / DMA_MEM_TO_DEV)
  axi_dma1: S2MM-only (capture  / DMA_DEV_TO_MEM)

axi_dma0: axidma@a0100000 {
        compatible = "xlnx,axi-dma-1.00.a";
        #dma-cells = <1>;
        reg = <0 0xa0100000 0 0x10000>;
        clocks = <&aclk>;
        clock-names = "s_axi_lite_aclk";
        xlnx,addrwidth = <32>;

        dma-channel {
                compatible = "xlnx,axi-dma-mm2s-channel";
                interrupt-parent = <&axi_intc>;
                interrupts = <14>;
                xlnx,datawidth = <32>;
        };
};

axi_dma1: axidma@a0110000 {
        compatible = "xlnx,axi-dma-1.00.a";
        #dma-cells = <1>;
        reg = <0 0xa0110000 0 0x10000>;
        clocks = <&aclk>;
        clock-names = "s_axi_lite_aclk";
        xlnx,addrwidth = <32>;

        dma-channel {
                compatible = "xlnx,axi-dma-s2mm-channel";
                interrupt-parent = <&axi_intc>;
                interrupts = <15>;
                xlnx,datawidth = <32>;
        };
};

This confirms your suspicion: direction aggregation via
xdev->common.directions |= chan->direction does not end up combining
different directions within a single dma_device instance in our setup,
because each dma_device only has one channel and one direction.

>There's however one other thing you could test: Could you keep the RFC
>patch with the printks in place, but revert 7e01511443c3, rerun and post
>the logs?

Debug results with your RFC patch kept, but 7e01511443c3 reverted:
- Audio playback works (aplay plays normally)
- No xilinx_dma_device_caps printk output at all:
# dmesg | grep xilinx_dma_device_caps
<no output>



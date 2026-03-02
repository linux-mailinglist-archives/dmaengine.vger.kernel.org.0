Return-Path: <dmaengine+bounces-9161-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OZmF247pWne6QUAu9opvQ
	(envelope-from <dmaengine+bounces-9161-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 08:25:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D61D3E00
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 08:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ED5F302A6EA
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 07:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFBA333447;
	Mon,  2 Mar 2026 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc//uMn+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8A332EC8
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436287; cv=none; b=L5a83VYhLH0m+ALZj12xCVuaiKKEfO/AwGH9LCUz/pgw4lrQuq7Vj+wLTPzvauCJToBhOlgAPi/Z5A1alfRGMabCvJIei4aPOk9dBJHTUXPQaQs7fJB/x57Z0fc4LJKPkj6J+wf0915RiBmCEsOnNDpwiEsn4tjQuWR7M4Y0mg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436287; c=relaxed/simple;
	bh=ilkeyD8qZQOpsW+Xq7gCWaAiuV38Fp1tAggTNiSYlQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k58fbelnpaJl0RlhocePEXzWfh1snS7LfriQIm9PtunbtNiztKATBVlJj+k15F8p2mh2erQDWoycJ2f8rjt919XiaRuhCfnHtEnxhOvomMG/nRTnHSsHyP7RdcgBe6yxTOW6qCyo7U7xRccuawHGjGk9zruJ+f+EbSbDVoBkOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc//uMn+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824b32875e7so1904922b3a.3
        for <dmaengine@vger.kernel.org>; Sun, 01 Mar 2026 23:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772436285; x=1773041085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwUZOQ2ZJ7lWBPCWroaNir22y89SjANnXegT9KI0WTU=;
        b=Hc//uMn+uZvwUyjSaI1WtCZq+sporS7oeTCLT86a+JkQ6O8dLGejnwbRZuRggEIPcv
         oFJ+H+ZFa+nWbv8G+H43tPYXzqp1fnsZPuBeW7h49YfcqGx2rJY2FXIzdCCTFFm5bTfW
         jh+m4jYmcwi1ya/SkIgNYBfC+hF2K/xM+QPaWxQik0HdeeBmWcDJvbj5FioimUYEhToF
         K3dQ3Pz7jS/G0HNGrkYMR7lMeUck353WQ/9rpDb1Z1wHTorBuQ84z8JURBuJzQW7PvrG
         yBqVaHt/Q95xKjrQxvnSz13KH4KjXCZalr/TFjlhdEOT0W2PBfe43eGqfU2TtYUPlkeI
         jdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772436285; x=1773041085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwUZOQ2ZJ7lWBPCWroaNir22y89SjANnXegT9KI0WTU=;
        b=ArsBYojqDKAwdTL99kLWmQAKEleytPgsO3Qlyq1vj1DlxWDyfnLq5euIMgpDt81PdH
         jWblm7iwS7IT89VPoB4k3lLYRKQFynWlgJnMb91svahs8AFaT561nbAtPE7ZamlI8muj
         TC96xlA3gM5VFfIjrKii0WV71XeGG6Ck6BrnmgqZ67AFOPQAclGMAgJwRVGElODNkXa5
         nLzLbAGXJRYFgiSERoRC526/zwmdL6AR76ZsA5oc95Q5/+dGu1exlvSBs1K5ZDLuE3Xb
         qwZhQE4P4mob0ARHD6pttx3zgCYxUnKC7ZcdJi34NRIbUm/O+beZvs2+1r/4g5TbOEiR
         O1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3uXUSqZWzzlqOiehQNSiGhuJ1KAZk2AMxpGIM/IEHQDgLNwDHOq07H1vCEy27EAq1Q0ZRur0yNx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3LeM7QNPSytJRoTEsGGIAy1m9uHT3odF7IgzFeomBHciva7bU
	/Bl8jhHcsZmWRGjafo8jBdvBO5ilvAc3pDzSJHidsyVbvx6JN6NIz4IB
X-Gm-Gg: ATEYQzyzVugEAFypw6oaY/D5sJImOo1AkziU1/4vpkItPR/tt9E3HViuxQdcxYiQtdz
	p8mzRZoTiMGkKxVUxdWVHehOgSomh6H9oYlaCrBXAFwttkeS/Wa2zBRlHHP3XAzLux1zYs6BPdu
	lLkFhw7fYe/HG5ddBesMacZdHvipq/L9pdzS6fKhFLXiFKQ9lg9ju81u+RxqYUlF+Ox5YZslK0Z
	iWrm8Mq3rjaHQURS39n1r1N74WSgNeufR8wmXrmDnivtfhiBcwrnN+70QQPvA6Q9MMZpMa62A9L
	O7D9BGem6RmobDWSgTk9VoBmJ1DDRAal/+HwSJTuubykfYnvSdPp40c5Rsw/efJ6esJ4AtGf99Y
	Mto1hS9gWMpYzsypG0E622XrPhIBngvmnmmX9y9s8J7jZQYCQGBc+IC1LNGFi/YZZRw3VVO7Ek5
	JXNft29VIOxs/gVgnf9WcDmOVtpp4aYYdm
X-Received: by 2002:a05:6a00:3c8b:b0:824:ae74:571f with SMTP id d2e1a72fcca58-8274d9e60dfmr12793620b3a.40.1772436285118;
        Sun, 01 Mar 2026 23:24:45 -0800 (PST)
Received: from bsp.intra.ifm ([123.252.218.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a0107f5sm11709615b3a.45.2026.03.01.23.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 23:24:44 -0800 (PST)
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
Date: Mon,  2 Mar 2026 12:54:32 +0530
Message-ID: <20260302072433.5091-1-rahulnavale04@gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	TAGGED_FROM(0.00)[bounces-9161-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rahulnavale04@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[a0110000:email,a0100000:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ifm.com:email]
X-Rspamd-Queue-Id: BE2D61D3E00
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



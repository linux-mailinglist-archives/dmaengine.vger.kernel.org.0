Return-Path: <dmaengine+bounces-9269-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFYMOgI/qWnK3QAAu9opvQ
	(envelope-from <dmaengine+bounces-9269-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 09:29:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED1C20D76B
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 09:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30FF4301E966
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1889329E7E;
	Thu,  5 Mar 2026 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6bJlRMw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D682EB87E
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699371; cv=none; b=USzYqQdIygZvU0FwvaV4/A3C1yLuI/TCZltT6znmuIneq4QcWqrDNf07a/LxznP5bcPZnVSlX7TrwBKO4o0uMqLuMRkKWKuouTuGQcH6LJcbOC1eviHafCj+eBBkdQQ9enXfmx6OPW6O3XRXo01sSNDu1mq3giJWru+/K2CNaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699371; c=relaxed/simple;
	bh=jH+e+v82gVnDOt60DWUZHAal9LIITYOK/nURxsQknQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnxLzZV70slH/fiypbIiariTb2a/31RvL9U1vPjbnI0jpN67qY40OSjQEV2OGGUjwgZ8L2Nl2lbPdlQrByEcg+zvBnQTBkNn863QrELZW3vLHlWv91nZkc1o9LpXqD9Rj7qrd6ETkv2e1HfT2PDBYBzUhmb1msVK3+7vWufhc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6bJlRMw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8296d553142so906405b3a.3
        for <dmaengine@vger.kernel.org>; Thu, 05 Mar 2026 00:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772699370; x=1773304170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGYEzO7qkE8Sc5u/+WF8bOCRqDgQZaCrql82uLk7zds=;
        b=W6bJlRMwgBIhB2+609eoNs3L2OeTEI6uYmNHH7xpbIiCOstgIcnP5Vb3py2fQvA276
         W6UW6zs9r4fevdLP7JKq/xB5xG/jH7yjP6j3mIUQv9rirDJcJvb6SZgZ/N4ZuITBBK9m
         zIV6tWilIwTtaDQ7CvHzXMdiiKg3BBI7NtG9GDo7DyEcfE19pTnA5qx9oHjao1UhgVNt
         JEDTpO/7ZmtylqkEHL+7YSPT/6wSsCq+A3IKayLhQiusHiBiZgJkBd3biBpaNLa79nvx
         HUFngnhtwJz0jTEcYmHsyKYWPm57WO2GtJkt3zLb79rUzhIIYQXiW4UOaVTxYOufqbwb
         9pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772699370; x=1773304170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGYEzO7qkE8Sc5u/+WF8bOCRqDgQZaCrql82uLk7zds=;
        b=fXThaX4dZxPYB/EAipsQy8l9cpLUXnuS70Jg0IUwBub2/VwdKg/m3nBrvcghKdCUQ0
         TXf30jKmlqNc/4j8bStxSshnywDU0LUn5EMM2LXr8t/8ly3vFfx0y8ZVph2AlCw8Gcxy
         Fhy3/Bh639gQCqx1VGgEYEmBA28djFYXv/f9pOamX30rQ2XkKjbui0gwK8pYOM3SkZwc
         FU2jyySaXS+Ny6kWF83CzvCNyxTL7vZbG88/8/l263cb6bIdxNCF/ezVXDGHYRP7o6Jj
         /gRwG8PRlwZz7MLDUi3yMGzwXFTg48Y6/XVxCQUMLYyYf1qHNcXcMr1YSVt3bcjxPUUh
         CbiA==
X-Forwarded-Encrypted: i=1; AJvYcCX7wGBSIoX/tMRWJg5+RxuS7PfqUQG/QnT+PMA9TXRNMfD9JbPNMMUpTkcuS8bJMOCOrIIgx1rn/AI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4EzsqMuzvtZ3OxaxybQhO9VIRBIuOCowb7917dVhfgJXaulFG
	741yOpEiu0+nRuZW3AFijJbCOSBj0ovgBGN+/eXU9rhTqqGflZk42tr5
X-Gm-Gg: ATEYQzxF0Ujq7Jm/PEXzvbQS27PWPTpxzd6qd/lVbxZMBI4zmzQPUUZM8Li94bD4NT8
	RATSL+BzRQpLV7Ltv63qm8/DnbFuGidw/tDoSoVllpdg63u9N1U1+tvp5WU1g4JAYG2Su85VMyH
	9CDTlA/IN58av9CcfoZIjMllBoq8tWRZ00Bvp/RX8DfTD1w114bx2pxiK3yiFv64asKoH/4UPBY
	cDEstOc/asSpt4DoU1OvI7QyI4q58eJcGctf30g2dPF9X/6ssTqHcMkryOeZAM0VQqn0udmuQ/m
	bICXtjIgQMOOkq7ss7OlwyoQRgr2X9s3j3hTUA/+UEm862NijYsKql1aQzaNdHniS9SnQE+jiaV
	ZqwIhaxK8/2I1nYJP04RoqeUUGMciHacvbkflxv+zDVCozmEGTZqLckC9oGmVe9fdiXdGAM21ja
	SUmeQMvhRr9uTF+2eme+eaGvtDgzw=
X-Received: by 2002:a05:6a00:12e6:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-82972b58c4amr4691981b3a.23.1772699369906;
        Thu, 05 Mar 2026 00:29:29 -0800 (PST)
Received: from bsp.. ([58.84.61.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8298e640d6esm811574b3a.52.2026.03.05.00.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 00:29:29 -0800 (PST)
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
Date: Thu,  5 Mar 2026 13:59:17 +0530
Message-ID: <20260305082919.5940-1-rahulnavale04@gmail.com>
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
X-Rspamd-Queue-Id: 4ED1C20D76B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	TAGGED_FROM(0.00)[bounces-9269-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ifm.com:email]
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

>Could you show the debug output from dma_get_slave_caps()? 

logs:
<4>[    0.302360] dma_slave_caps:
<4>[    0.302364]   src_addr_widths    = 0x00000000
<4>[    0.302368]   dst_addr_widths    = 0x00000000
<4>[    0.302371]   directions         = 0x00000000
<4>[    0.302374]   min_burst          = 0x00000000
<4>[    0.302377]   max_burst          = 0x00000000
<4>[    0.302380]   max_sg_burst       = 0x00000000
<4>[    0.302383]   cmd_pause          = 0x00
<4>[    0.302386]   cmd_resume         = 0x00
<4>[    0.302388]   cmd_terminate      = 0x00
<4>[    0.302391]   residue_granularity= 0x00000000
<4>[    0.302394]   descriptor_reuse   = 0x00
<4>[    0.302398] xilinx_dma_device_caps: caps->directions = 0x00000001
<4>[    0.302401] xilinx_dma_device_caps: caps->directions = 0x00000001
<4>[    0.302404] dma_slave_caps:
<4>[    0.302406]   src_addr_widths    = 0x00000000
<4>[    0.302409]   dst_addr_widths    = 0x00000000
<4>[    0.302412]   directions         = 0x00000001
<4>[    0.302415]   min_burst          = 0x00000000
<4>[    0.302418]   max_burst          = 0x00000000
<4>[    0.302421]   max_sg_burst       = 0x00000000
<4>[    0.302423]   cmd_pause          = 0x00
<4>[    0.302426]   cmd_resume         = 0x00
<4>[    0.302429]   cmd_terminate      = 0x01
<4>[    0.302431]   residue_granularity= 0x00000001
<4>[    0.302434]   descriptor_reuse   = 0x00


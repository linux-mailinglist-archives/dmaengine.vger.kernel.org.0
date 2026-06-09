Return-Path: <dmaengine+bounces-11347-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r5uJO7BiKGpPDAMAu9opvQ
	(envelope-from <dmaengine+bounces-11347-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:00:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6583B66378F
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:00:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LprvL37F;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11347-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11347-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E24BC302AF2E
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A854C042E;
	Tue,  9 Jun 2026 18:56:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCD43CED8
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 18:56:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031370; cv=none; b=AcoDhXeBjMkQZMXnZJWcsZWr7EsxUCw5p+pqdPBq/LZ/8qYFpN3y/eZsvoanye9O3rjHa+Zz248PMJ6iZGFlj8JtyDnH6NwkCe1D4mpFyPjOQo88q87Vu4IBqO8U8wKZmIP3McK1304rkIvNjE4AqVUcNFdDPTpsVSdgn7zjXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031370; c=relaxed/simple;
	bh=qv6NSO78UBvOvcAVkfVRgLKn0cSCdV/ghe8m+ViedI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn0Gpoz1Z33JWlZZCk6JGCrJx7Llo6wl7i62Hx8a7qwY5WjZe1KlA1TSBGbgrcE5F07rhPUTVCZeF24bV6d5sxg0n4cmaFo3ovJNUJ04SMCTlPLzBPPg6PuDy1FKEIobuZiGDO6XaLdt4uIYUgdzUttzEjiBCT3F0JnawOzoVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LprvL37F; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c168baac83so28020355ad.2
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781031368; x=1781636168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G32fw+YDIkyZWRzyQasWU1L7Th532AaegrDAEvejK28=;
        b=LprvL37F5cyQsW0v81KBieOjrnbS8NbroJLNov1d2U31oYSFgUhGFE7n2/qIEmB8nH
         1jNIJLIXO9J0mZ3D46KdZkA17J0r4JwqMKYFtBxvW9HzyMQsIhvJbrWw3Vpj3a8VNrXB
         qU0uMR0o9r2o5rg//WJqXEA7j/6N6p2elUGrTM/zaH8rwwBsIXJKrIeiEazOHVkVbyqk
         Az2UoUorLA9OKMcMlzWRuR34b6ktOZRlTNoE4uvergJDm+3cEs73iwBC23lcXrnQN5NS
         lF2LxhS6zcrOLRFjWO4rg423l6QpUUdcT8FBsOwnfFVVN0eErSXeMwtZX4A+oHSaVlvd
         PUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031368; x=1781636168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G32fw+YDIkyZWRzyQasWU1L7Th532AaegrDAEvejK28=;
        b=UMY4U7F2kRhtUoSU5dLmKBJdoXcC0Hoj1LH2cOJ3L32N/0ESTFTnzK/dO+HEe7VLWx
         cxdYiAGAIBdHeJTAG6l6Uvo5vLB/fyJIcbpB1cImN/2g+Cl5C79R3d9NSlEg++DIndmZ
         /ch7RHLH8Q3453vX7xMhznE3oFUqkZ/jptIEBFnf+yZuDU4uMRYoeQcr+AUr8/imj+4d
         HmDXHuKa79boClxWyn9VF28hDZmqibrje9vzOEVk0Kv1s0jx+oTFZcM38AkqlpZHmFTm
         LDsdEXnSa0cqhXEiBy9JDXVWphPnp5SI9wewaOgHrU1fjo/OhGVuPx85nzZ6vH7Jkrq1
         iCcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pWKNzoV++Dvn/m5h+t/UEaoS0sQ2ZGGaTfSGx46EHA5U2CK4KX1A3diob14HKov2BwFG4WhKzggI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzlLLe3guuEWnIUv5UtCDpBqPmQOt9J0R6Ub/jHrdckUKBxpcF
	YEmns/dH4QAQkNNkcnWhxJKhABT2bzNXNo5WdVrlrVcmcDoEkbF95se5
X-Gm-Gg: Acq92OHFYOPkiYoH985lmv4ifnLIZICL0MMXsIoQ7R5FUovPzousmZ4QW1q7RFK5n1t
	L93wcgKbn5l/oDzbMuxsUcgh/HSza3UMSN1qh963Cq0DCV1QAzo1yLkW2R4nLyiFRLLemAC7MrF
	y6qLXa2WiNmEymzGDeXvA6tEKeTO/gwmutIzUACQZzj7rwQz5uGweHvgP6amJ5AVRw7JLGWJbC3
	e/U+CG/5UWmPkYc59BMDAEm7sMo557nQp/uQ7culQFWpmknWc0CpIUCbpmD7cYpnqYJhjSGcGUz
	9fWBkF/aVwV6du2AVUcT55r90G68wnwGyn3VIPbhyC7W2La+5+yMMeCf4VbWkBHiz+bdg+9YPSd
	d93FPknoGRkoCrwxLAqEXHh80vxs2kyRvk9M6ibOv7NkRV32b1hMHePjXu9hCl85+5dDkILw7cV
	q477m3zg==
X-Received: by 2002:a17:902:ced1:b0:2c0:fa4e:91f6 with SMTP id d9443c01a7336-2c1e7d41eabmr240045285ad.13.1781031368012;
        Tue, 09 Jun 2026 11:56:08 -0700 (PDT)
Received: from localhost ([2a12:a305:4::3060])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c245dd3b5dsm95637445ad.81.2026.06.09.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:56:07 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:55:59 -0400
From: Guodong Xu <docular.xu@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add SpacemiT K1 PDMA request
 numbers
Message-ID: <qxcpvj3eseclgonwuwx2szn2tj4uxci27mvpqwotj6uaiyj65p@7sx5tyzbfs2g>
References: <20260607-b4-k1-pdma-req-macros-v1-0-5b2a3955007c@gmail.com>
 <20260607-b4-k1-pdma-req-macros-v1-1-5b2a3955007c@gmail.com>
 <20260608-dazzling-hacksaw-dbe84766ec76@spud>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260608-dazzling-hacksaw-dbe84766ec76@spud>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11347-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dlan@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:krzk@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacemit.com:url,vger.kernel.org:from_smtp,7sx5tyzbfs2g:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6583B66378F

Hi, Conor

On 2026-06-08 18:33, Conor Dooley wrote:
>On Sun, Jun 07, 2026 at 01:41:30PM -0400, Guodong Xu wrote:
>> Add a dt-bindings header that gives symbolic names to the SpacemiT K1
>> PDMA request lines of the non-secure peripherals. Device trees can use
>> these K1_PDMA_* macros instead of magic numbers.
>>
>> Point the spacemit,k1-pdma binding's #dma-cells description at the new
>> header.
>>
>> Signed-off-by: Guodong Xu <docular.xu@gmail.com>
>> ---
>>  .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  |  4 +-
>>  include/dt-bindings/dma/spacemit,k1-pdma.h         | 56 ++++++++++++++++++++++
>>  2 files changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
>> index ec06235baf5ca..0d4ac9849e27b 100644
>> --- a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
>> @@ -35,7 +35,9 @@ properties:
>>    '#dma-cells':
>>      const: 1
>>      description:
>> -      The DMA request number for the peripheral device.
>> +      The single cell is the DMA request number for the peripheral device.
>> +      See <dt-bindings/dma/spacemit,k1-pdma.h> for the list of valid request
>> +      numbers.
>>
>>  required:
>>    - compatible
>> diff --git a/include/dt-bindings/dma/spacemit,k1-pdma.h b/include/dt-bindings/dma/spacemit,k1-pdma.h
>
>Why does this need to be in a binding when there is no use of this in
>the driver? May as well be a header, particularly if these are numbers

Thanks for the review. You are correct that these are not referenced in the
driver. My change to k1-pdma.yaml should be dropped.

>with a set meaning that are lifted from the TRM, rather than made up
>numbers to make a driver work. The former seems likely, given you're
>indexing from 3 not 0.

Yes, it is defined in the K1 manual [1], see 9.4.3 DMA Connectivity &
Assignments

Link: https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k1/k1_docs/k1_usermanual/9.Top_System.md [1]

I will fix that in v2.

BR,
Guodong

>
>> new file mode 100644
>> index 0000000000000..491976516550a
>> --- /dev/null
>> +++ b/include/dt-bindings/dma/spacemit,k1-pdma.h
>> @@ -0,0 +1,56 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * This header provides DMA request number for non-secure peripherals of
>> + * SpacemiT K1 PDMA.
>> + *
>> + * Copyright (c) 2026 Guodong Xu <docular.xu@gmail.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_DMA_SPACEMIT_K1_PDMA_H_
>> +#define _DT_BINDINGS_DMA_SPACEMIT_K1_PDMA_H_
>> +
>> +#define K1_PDMA_UART0_TX	3
>> +#define K1_PDMA_UART0_RX	4
>> +#define K1_PDMA_UART2_TX	5
>> +#define K1_PDMA_UART2_RX	6
>> +#define K1_PDMA_UART3_TX	7
>> +#define K1_PDMA_UART3_RX	8
>> +#define K1_PDMA_UART4_TX	9
>> +#define K1_PDMA_UART4_RX	10
>> +#define K1_PDMA_I2C0_TX		11
>> +#define K1_PDMA_I2C0_RX		12
>> +#define K1_PDMA_I2C1_TX		13
>> +#define K1_PDMA_I2C1_RX		14
>> +#define K1_PDMA_I2C2_TX		15
>> +#define K1_PDMA_I2C2_RX		16
>> +#define K1_PDMA_I2C4_TX		17
>> +#define K1_PDMA_I2C4_RX		18
>> +#define K1_PDMA_SPI3_TX		19
>> +#define K1_PDMA_SPI3_RX		20
>> +#define K1_PDMA_I2S0_TX		21
>> +#define K1_PDMA_I2S0_RX		22
>> +#define K1_PDMA_I2S1_TX		23
>> +#define K1_PDMA_I2S1_RX		24
>> +#define K1_PDMA_UART5_TX	25
>> +#define K1_PDMA_UART5_RX	26
>> +#define K1_PDMA_UART6_TX	27
>> +#define K1_PDMA_UART6_RX	28
>> +#define K1_PDMA_UART7_TX	29
>> +#define K1_PDMA_UART7_RX	30
>> +#define K1_PDMA_UART8_TX	31
>> +#define K1_PDMA_UART8_RX	32
>> +#define K1_PDMA_UART9_TX	33
>> +#define K1_PDMA_UART9_RX	34
>> +#define K1_PDMA_I2C5_TX		35
>> +#define K1_PDMA_I2C5_RX		36
>> +#define K1_PDMA_I2C6_TX		37
>> +#define K1_PDMA_I2C6_RX		38
>> +#define K1_PDMA_I2C7_TX		39
>> +#define K1_PDMA_I2C7_RX		40
>> +#define K1_PDMA_I2C8_TX		41
>> +#define K1_PDMA_I2C8_RX		42
>> +#define K1_PDMA_CAN0_RX		43
>> +#define K1_PDMA_QSPI_RX		44
>> +#define K1_PDMA_QSPI_TX		45
>> +
>> +#endif /* _DT_BINDINGS_DMA_SPACEMIT_K1_PDMA_H_ */
>>
>> --
>> 2.43.0
>>




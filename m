Return-Path: <dmaengine+bounces-9499-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKxyH/v8uWnZQAIAu9opvQ
	(envelope-from <dmaengine+bounces-9499-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 02:16:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E347E2B4E26
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 02:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 074AE3099153
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7222173D;
	Wed, 18 Mar 2026 01:15:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BBC239E80;
	Wed, 18 Mar 2026 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796547; cv=none; b=ZpEL23zUmyKGBWQs5jrEC0yXUYJjuHWiuWoCnc/CuxsAgCmI0dbNYF+xi7ZWARSVYl4kKvibZoMnlV5M3YsUwGy44Jugly3UjZ0EtzfSynNeUC2B2RVr98FsFMyrBR9wvFN5R1szaXZ46ouPpJ9k6SZohTls/j1Tv3pDT8kBaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796547; c=relaxed/simple;
	bh=m4gqK+m1RE7m+Zr1k7emtKyeQ3ziw6gjCVOKEoalsNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbvxFHzOOESKdZwUl/dYebQxpZssN3uTRn8KtDkmTaFJBzpXmvfILQO9Txi2oR6tXTpZJcS27U/t4C4S3Qt5kh3HkOIVVk8qPcvIUerPKRACr7alWpAW+FkdGKHjngUiR3oKPNqYEfP1GGobygXZONv/29n0buBej46vhz3bmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.17])
	by gateway (Coremail) with SMTP id _____8Axw8C6_LlpHyscAA--.22483S3;
	Wed, 18 Mar 2026 09:15:39 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.17])
	by front1 (Coremail) with SMTP id qMiowJDxxsC3_LlpzGhXAA--.31410S2;
	Wed, 18 Mar 2026 09:15:36 +0800 (CST)
Message-ID: <97eb2f72-024b-4397-9281-88a3267aa60e@loongson.cn>
Date: Wed, 18 Mar 2026 09:15:35 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] dt-bindings: dmaengine: Fix spelling mistake
 "Looongson" -> "Looogson"
To: Colin Ian King <colin.i.king@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260317204938.120729-1-colin.i.king@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20260317204938.120729-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDxxsC3_LlpzGhXAA--.31410S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEJCGm47UMvtAABsk
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw1rXF1UZF17Aw15GF43CFX_yoWkXFc_X3
	Wxtan5Zrs8ZFW29a45Zrs7tFy5X3W2kFn0k3Z8Jrn7Z34Fgr90gF97X3s0kry7WFnruF43
	ZFs5uryrur47KosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1RBT5UUUUU=
	=
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9499-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,loongson.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: E347E2B4E26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026/3/18 04:49, Colin Ian King wrote:
> There is a spelling mistake in the title field. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks a lot.

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>

> ---
>   .../devicetree/bindings/dma/loongson,ls2k0300-dma.yaml          | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> index c3151d806b55..8095214ccaf7 100644
> --- a/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> @@ -4,7 +4,7 @@
>   $id: http://devicetree.org/schemas/dma/loongson,ls2k0300-dma.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: Looongson-2 Multi-Channel DMA controller
> +title: Loongson-2 Multi-Channel DMA controller
>   
>   description:
>     The Loongson-2 Multi-Channel DMA controller is used for transferring data



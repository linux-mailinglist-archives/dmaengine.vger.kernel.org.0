Return-Path: <dmaengine+bounces-6522-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2923B58572
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 21:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8242B4C033E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A387285C9E;
	Mon, 15 Sep 2025 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XC0C+5Fj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E22857DF;
	Mon, 15 Sep 2025 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965358; cv=none; b=jeb53QwhCZJNuCLQInrv382t4dLmsH73yMQhg5P/fUXNOrga3+SaOqYnyJHUQ+bA887v8IgSV1GeozuXn5TMAryqhYZZH6HbZGfYMSqIx6oEOqlbidKypdUYqhN51IdJQuASZrVEneVayN2Iyx1ClOTUQV/SKsbtBWOmy1nWKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965358; c=relaxed/simple;
	bh=qvdfrmIh4NPZ+/uFWRTsWiFWhMxKPa1Mtj3ZAi4h9tc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XxItwPv+bNgwInIRrPsf9GtIxr8k0LZtJEygY777nbufJXrQgR4178TnOkI/WgoHUO2OlLKB/UZ3RlUxbjaXbdhKGZe0BNUZVEWZDd3CUFrAbYyi4RLEcsZZK4+3a+xfd3tD+iNCLCfMv8ZRSrbMDJrr88N5IHn9scHKsnoGv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XC0C+5Fj; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757965353; x=1758570153; i=markus.elfring@web.de;
	bh=aUqQg47bU5dHFZff7pqPCsLxzj0NS3+A+Ftm+3s7ajI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XC0C+5Fj7JZSzWNU36ChN3OmMoB1epdRzinqri5OU/gKfsk/ouky1TrQBNubT5rm
	 TFQy5v8P0pJohbdpRnEDZxmk91wRNuwahUOjHqTbAqTIRAhN65Z8Oj7qOf4v3rJuQ
	 9RsXOHn/5u8z7Hdy7KH3yEicqTQTsJ32R2Ktqit9thbgJDx5cwzQDJxQCKNa+yF1r
	 HwGFQ/pKEwcDjqklJrPhD158pdRtW6LdHu/FXmMG0deODnW4EZ4AK64zyxx7TwiHg
	 x4Z5b3+Vd5vUYcSRjJiO2Z/tq0KR22DQvXbpTyWUKOc+GfEF6X6ZKX17C11L6hW8F
	 pvQ6gRw0tSdyxbdDFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.188]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mho0A-1uTbFA41mC-00hZRX; Mon, 15
 Sep 2025 21:42:33 +0200
Message-ID: <063c5035-36d3-4b81-8ae6-b05cf9d27066@web.de>
Date: Mon, 15 Sep 2025 21:42:31 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nathan Lynch <nathan.lynch@amd.com>, Wei Huang <wei.huang2@amd.com>,
 dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Vinod Koul <vkoul@kernel.org>
References: <20250905-sdxi-base-v1-8-d0341a1292ba@amd.com>
Subject: Re: [PATCH RFC 08/13] dmaengine: sdxi: Context creation/removal,
 descriptor submission
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250905-sdxi-base-v1-8-d0341a1292ba@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LYT74sEP1AsKEyNdyJRJff4Rsm7TQbsDI8AXNbkcgvsYMaZN3Z3
 zcb7feQqYncO+5ICYy4CxKRx2X+YcG+Sm8RAJzDBU9fK31rwH2mNxfB2n/C1JnnrJDuL/ZU
 98qtihPSvPCgN2EO1tpovT28mGJ44HCZ3oHomkMhnPDJf43osbNN+j2fqWHITZh+vn/2sKd
 I8zQq7CD1PUbPRxqzJaIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9fkPiu86wRc=;jzifq2Pz3xWhlo8+2ouT01F7nwy
 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
 igymL2v8qdpOJHH3rae

=E2=80=A6
> +++ b/drivers/dma/sdxi/context.c
> @@ -0,0 +1,547 @@
=E2=80=A6
> +static void sdxi_cxt_free(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_dev *sdxi =3D cxt->sdxi;
> +
> +	mutex_lock(&sdxi->cxt_lock);
> +
> +	cleanup_cxt_tables(sdxi, cxt);
> +	dma_pool_free(sdxi->cxt_ctl_pool, cxt->cxt_ctl, cxt->cxt_ctl_dma);
> +	free_cxt(cxt);
> +
> +	mutex_unlock(&sdxi->cxt_lock);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&sdxi->cxt_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.17-rc6/source/include/linux/mutex.h#L2=
28

Regards,
Markus


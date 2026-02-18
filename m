Return-Path: <dmaengine+bounces-8959-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F1ZD5jflWneVgIAu9opvQ
	(envelope-from <dmaengine+bounces-8959-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 16:49:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A1A1577A0
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 16:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C38E3300668A
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDC634321B;
	Wed, 18 Feb 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dulDhNSj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55180342CA5
	for <dmaengine@vger.kernel.org>; Wed, 18 Feb 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771429781; cv=none; b=crWJ+oJguyoOx21IOzj8ZQt4sjBqGLUhn6U/4MJXSCQ+HEsk2byRcNJY7FnR8CQdEt3ZHP1IZFQvhZ9j62O72/IX8O0eJmt5T3Tz/kIV3C/ABNswAW7FpfZayq97wucWUQFoEi5WQiOq4NcoCmkfWaritO68oPs0nhsnDmi4+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771429781; c=relaxed/simple;
	bh=6s/DRXe74fLPKwvA6jsEImtBpQp1apKjuEkG2xpenu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6eXReKRLjKcCW67+y5B8uTGUDuoKkf+i1/W9tIOGwkvU1TeTlZzXdA98WpdAmZVZdkqe6iXCgQXndm2Y8bUouA/o1zrIk1LvvWEseRYLSx2Sfk+rmPK+ElWP0m+0u1ZWBlBiOuN5Bh+/w2xXmSX9TlmPc94V2sirXaPkfpwtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dulDhNSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0638FC19424
	for <dmaengine@vger.kernel.org>; Wed, 18 Feb 2026 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771429781;
	bh=6s/DRXe74fLPKwvA6jsEImtBpQp1apKjuEkG2xpenu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dulDhNSjiR4mEtDJA4ZsVMQmZmTFuohmKaWJNV27y7lLuy92UTuRIYTm9YO9gJBIH
	 8f7aImf1f6HGcUOvLhyKCiIRl2H8anWf/LAGPM3lncGRw57sGsQQ5HfGtGTEoYXu1i
	 5r0rERtcHVeyoa3vgHhAJPG9uRmHWYBMZN0hQI3smQTIlTz9IKOGzx/fDzsRmdb43x
	 NyMQlMrCiC5E7LDqH6/id4uFIUXEz8gF0K5EJCxZ4MwvV9UH+OZdHKkRr0N/QbGaIi
	 FXLRRJDu6hbrfjjx8B4q1ajBiFVwrBFFneR3xdx6E/yOgtT/mYH2TYpFc9TvGN+XDZ
	 DIaMJCrTcpdPQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65a3fdeb7d9so7832722a12.0
        for <dmaengine@vger.kernel.org>; Wed, 18 Feb 2026 07:49:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkE1FatH1pjKsO99+8Zzet0dqUKkUQwaZMfAKUY95LOQydjQUA/WyvbcgoBnqjyviz7nQYONuoWzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Hy11M1jkDlv4svsvRJGYCI5VbhSR1bGJCR54Nabkdj/2KqTn
	AMtehjS8vXJHO+rKiW2iLMmCl1nIKXMRg+zbj/lTu1gtN0NqLIG2AM2YDOLmu0phsXO84XSP6RL
	0Mm1FVtvcHT1RtXavhpWXHoKUv4K/Gg==
X-Received: by 2002:a17:907:86aa:b0:b73:4d06:bc8 with SMTP id
 a640c23a62f3a-b8fb450a23fmr946321666b.53.1771429779464; Wed, 18 Feb 2026
 07:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
 <20260217173457.18628-2-akhilrajeev@nvidia.com> <e26ac880-c397-46ee-a308-be2de608e3d4@kernel.org>
 <eb42fefd-758f-4c02-86fe-01d21a08e101@nvidia.com>
In-Reply-To: <eb42fefd-758f-4c02-86fe-01d21a08e101@nvidia.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Feb 2026 09:49:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL6+U__jOGyoZCHA1KMopP+=QoKuLC0K90rb_XJfqq9xA@mail.gmail.com>
X-Gm-Features: AaiRm52YUr-ugyU80YIG6Uftdjkq2NKQ_2lfpPCd9EUbe6TXgMNQrQzHTFBaJg0
Message-ID: <CAL_JsqL6+U__jOGyoZCHA1KMopP+=QoKuLC0K90rb_XJfqq9xA@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add
 iommu-map property
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Akhil R <akhilrajeev@nvidia.com>, dmaengine@vger.kernel.org, 
	linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com, 
	p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,pengutronix.de];
	TAGGED_FROM(0.00)[bounces-8959-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: C0A1A1577A0
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 3:59=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 17/02/2026 19:53, Krzysztof Kozlowski wrote:
> > On 17/02/2026 18:34, Akhil R wrote:
> >> Add iommu-map property which helps when each channel requires its own
> >> stream ID for the transfer. Use iommu-map to specify separate stream
> >> ID for each channel. This enables each channel to be in its own iommu
> >> domain and keeps the memory isolated from other devices sharing the
> >> same DMA controller.
> >>
> >> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> >> ---
> >>   .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml  | 8 ++++++=
++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc=
-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.y=
aml
> >> index 0dabe9bbb219..542e9cb9f641 100644
> >> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.ya=
ml
> >> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.ya=
ml
> >> @@ -14,6 +14,7 @@ description: |
> >>   maintainers:
> >>     - Jon Hunter <jonathanh@nvidia.com>
> >>     - Rajesh Gumasta <rgumasta@nvidia.com>
> >> +  - Akhil R <akhilrajeev@nvidia.com>
> >
> > With 4.5 trillion USD capitalization of Nvidia one could assume they ca=
n
> > spare few resources to test the patch before sending it... instead of
> > relying on Rob's and my machines to do that for them.
> >
> > Expect grumpy review because you do not care about our time.
>
>
> ACK! We need to do a better job here. I will work with Akhil to improve
> this.

Anyone that wants to run a gitlab-runner (and docker) on one of their
machines to add to the test capacity would be more than welcomed. It's
pretty trivial to set up. The only requirement is something faster
than gitlab shared runners. My 2 machines are M1 and M3 MBPs.

Rob


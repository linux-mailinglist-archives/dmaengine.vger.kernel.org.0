Return-Path: <dmaengine+bounces-9709-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMGbAmQ4ymlf6gUAu9opvQ
	(envelope-from <dmaengine+bounces-9709-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 10:46:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A23E357713
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 10:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F5FE3005AA9
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D853AB27C;
	Mon, 30 Mar 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5LSGpuD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421439DBFB
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860384; cv=pass; b=a/U1uOCKzRvS/DETvm2u3iuykDcI4lRvH2VNi5Plnk/NNwzlHnP40w2s9Ek5H7v4SrV88DbRhDw5HxbCbMn0t3r/lYnK1myVUyoiwvdXKYhvVrpJG37nIxQWFJLz/xVWj58gsdSFObU8pyllYUXBwudwBwkHKWwn9wBewjkLzUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860384; c=relaxed/simple;
	bh=QxDfPaftSvz+dpA0njCWwKFR7kOEN38NSwOeQcS5Y+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tq6hQcW3fjKCNyE4xR6P095EfX/5T5YrkdePsQ9Y1kxS9ofDOuqOv189yglvy4Q0HaZCRZSRSSEGhGE5LoISvcaoBgKWBK+b1gII7RdSIemozf0IHjH0MOYqF0tfNoI3izeC2LmO+JWGUHDWGnjTTIbfvhWZZKLoKmn7eRHa5Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5LSGpuD; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66b1019bb55so4020209a12.1
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 01:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774860382; cv=none;
        d=google.com; s=arc-20240605;
        b=aRi7rq1psuj/6gTLaYOE+sl1Sw6Te+8J6DT0142VziraUmbc4ldntL5ErhOJ/OXtQJ
         I9Vmvf3km3/CjxyA/YuL48jCyrntj3UQA+U8EYozbOzxqMYXm1WDurawgPwt3++wOB9f
         KFWqhhljiq77lwUIvtQcnNMYrpZLcEOVGZzhKkSItpzmp8VqjcNrQCsiQ+uOn4EZbKSW
         LKh1yHjv60kJzJIJFbJ3dkQPvyEW0S35rsDfIlZjachzZoeWH7/FeiaJCKeXvZwxwOzw
         upJ/h9wFqIjT90cy1cfilJTGB/I6VqdO9jFYwDfQKENfyWnvhZ8EBeaMi0lQYPDVKFXe
         fdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HFdi+sAMmTXfvai5RWnTh1O1stM1wk8EESAWCob6UZc=;
        fh=22r3XkhgFXYlo01h1jYb+ZSltnvR0YVp6gSI4ip4x/I=;
        b=RDf+sLUgiHTCQD+8V4IHynRtcRs+eUmmUrG2Gfe2ZMdn2ZdezslRb+sDYV9SQ0FsV4
         fx9TVu4UAHhGYUo55/LufJUErKANXF5bcCa50YzC7+vNW9XnQabld33k9YIp/ef1oAJE
         hUAP7Iavyff1eFKoBqM+di3/gqkwmBTXwjyogaU+YM6EqPnrA8bqzFixm168Co1PzLix
         BYXnYZYCrzmd3pZuKG8X80ZU/fidaxwt7iQdrcWqHJEJElN5JLA0qODA7AYyz25i6yp/
         /tnw7OVQQBqLH0QiWIUMPpCfU2vVXv9mHttAh5TbsV1Q0T8S7s2E/cQHzkzDeIsRolKw
         zVcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774860382; x=1775465182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFdi+sAMmTXfvai5RWnTh1O1stM1wk8EESAWCob6UZc=;
        b=I5LSGpuDdwNpvffY2tGnC1XbAepwoMxsCxDrSdy/voK+zjwe+bujJbz98++UzfEAqf
         2qPH3hb6S1yrpLFul9mNRFUWCOKWzDe/2kZKLsov0rQMjydSSAimGMAVg1TNQvShPL4C
         rnMDBPWIULV/zDnP1kuQd85ukWpCOcO7FEUGILXUzbJ3Z64tPaTY5Cf/Xh89VfLT8D+u
         8sBJjJ8V0n+JnkyDqWHzhCBCDD3UggHiphITMdmniYlCIkRX0jIfPde/EbrS5Gj2DhzV
         PmH8U2aMsf/lUz23qXYJardlwhXDn4rQTE+HLeN+Irar/9BTzcnZEXcL6cEh8lFac+Hg
         U7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774860382; x=1775465182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HFdi+sAMmTXfvai5RWnTh1O1stM1wk8EESAWCob6UZc=;
        b=nSX6qEcVYUvAVJiGndfmAITdQBZM1UTBMZhenxJJr6BgoZ0xFqmsTni3kjTz3OP7xl
         UEZpQldX9CKOeEAjsTMYA0BDmNG7MWbn1d2C2BAd2C+US6Rx898IVvhvd1gd2FGUedvt
         qTijj4XKmiIl4EstayJmukiSE06O8NIoa6aJ4swo5TxyV1y2SGj7k/+v//fdFz31HOcz
         fnKad/ejlmbkzRSat33rgHMvVZZNujv1A5EWcC3daMko+AXrDseQpYomBy33naZxkL//
         MiQbvzENjJaxbOFJ92MVQ6EE1FkT4NwYiEquab4V7HvWvn6sk4+z1FDVOvBdraUp9ZPH
         eyhA==
X-Gm-Message-State: AOJu0YxdNQEaBLeOtBGb7hks9HFfgDYH1N68pZ/lZRWerEAKp59vAIom
	wPwRprQjWO+cR1/5QnU7T6NQBam+rgnrHPGD8rsQm8zsXgRuqel/La0hwW6zenAzIzRzoGyPjcj
	3fVPDiP4EpNiWnaJ82xAsnjiowdD7Kz0=
X-Gm-Gg: ATEYQzxxTRWWoJHfJ4uV8a6eKPK/TutWnyNKCicj88VzySyrESyvxBRT9kw4OkeZRQ3
	csNBUz/nGHScY6i/pFuSPTpoSl1npB7FjwWoe7KDVqFzN1KxXzlyAI6ANGoAxvbU8z75R8bEFwz
	KFa9xAOD8NjbTWStiyt+yHUPcvrb8FJKDCvwGZC93Zq0be3dHko1gUw614aWgPjVaryQVfFp4kE
	SsZ4fHRRH8PmH/t3S041EIyK2AqUMmk/IRaWd2rzTg9eyhqjGvelxRsXe/+ysgA+QfS56B80qKD
	A2Zwxldxwgzo28ldj7HRy94UOkPccJBQ6GQRpIqU5Am6Qo4+6B7ZF1lVcDjDVi9wqWGtNJNS/Z4
	eY4MNaPk=
X-Received: by 2002:a17:907:1c09:b0:b97:a12d:ffdf with SMTP id
 a640c23a62f3a-b9b509236eemr751885866b.38.1774860381552; Mon, 30 Mar 2026
 01:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com>
In-Reply-To: <20260328191646.312298-1-rosenp@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 30 Mar 2026 11:45:45 +0300
X-Gm-Features: AQROBzCSP-ZAq9l_JkG3Lk4O5AEzGIaeQWyy0gfG65bU_hKwDdH69EYGwCz99tY
Message-ID: <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9709-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9A23E357713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Simplifies allocations by using a flexible array member in this struct.
>
> Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
> this single usage.
>
> Add __counted_by to get extra runtime analysis.

> Apply the exact same treatment to struct hsu_dma and devm_kzalloc.

We refer to the functions as func(): devm_kzalloc().

...

> -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> +       /* Calculate nr_channels from the IO space length */
> +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHAN_LENG=
TH;
> +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channel=
s), GFP_KERNEL);
>         if (!hsu)
>                 return -ENOMEM;
>
> -       chip->hsu =3D hsu;
> -
> -       /* Calculate nr_channels from the IO space length */
> -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHAN=
_LENGTH;
> +       hsu->nr_channels =3D nr_channels;
>
> -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> -                                sizeof(*hsu->chan), GFP_KERNEL);
> -       if (!hsu->chan)
> -               return -ENOMEM;
> +       chip->hsu =3D hsu;

Don't know these _flex() APIs enough, but can we leave the chip->hsu =3D
hsu; in the same place as it's now?

--=20
With Best Regards,
Andy Shevchenko


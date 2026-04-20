Return-Path: <dmaengine+bounces-10031-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB8aF4rN5WlIoAEAu9opvQ
	(envelope-from <dmaengine+bounces-10031-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:54:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F14277CC
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18182304A6ED
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 06:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEC438239F;
	Mon, 20 Apr 2026 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAPI9oSO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047B383C69
	for <dmaengine@vger.kernel.org>; Mon, 20 Apr 2026 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667828; cv=pass; b=X5nsaityQIRgvyZgPIqP4sG1F0IWGVzWAzQM2387Hgnf7xzub9IInPv0C8hnniZ68CkqIzJRRDAP4u9OSNKqgNCO45f//ApRaEoqUrO9T+D6k+AvG6czVlRfJTHqtWWPYAiOoZmzvLxNb0l2y9SmesO8UHGRNYEyA+2274obMFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667828; c=relaxed/simple;
	bh=MsnKeJmQAtc/gZyPzJxnW3mK4tSSagZHSdASGcv5jLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPxp4mhyzY83R3pRMhqStank2w/zU/yCzDGXoEKYgDr5keNbZKFdUOEVqYHZkPOZaGO1PIaVgH+onzFkNWrt2sGoLU71/FG/4spLurvEd8rEffJ1o/Yumvsz/z0TvNWhpwecUvk3OT5jdArf9GZ1WaQBev4x7pYnPjaOyUS3/Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAPI9oSO; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6714f678bdaso4451461a12.3
        for <dmaengine@vger.kernel.org>; Sun, 19 Apr 2026 23:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776667824; cv=none;
        d=google.com; s=arc-20240605;
        b=SEGcRY1Bflq6fYbzqE5p78tn0sXB2AaB7V3QASFpVl3RNWpsI4BT4yFh0r+vT68oBK
         KczGi50b+jnGgU6LMjRnapOQK0ibqcJArPaUQjLR5yMJxY5+tZmFuH4XkaCDUroSfLkO
         CuRp3GUWBtwIAQ23H4KQYUXoxh6PkmkYHvMZrOXnbZZRmDokRpJ4bTBvjwn/rgmaaIDT
         lSR0rIgwDvJ6KkfbeB3VurnRRRIKdW4SR7b6RFaa/3c9n35MuzoudITGH6FFIy3fVh4x
         ZzfovqHKlIENA4/eWKP+pVkWJivScUFTUNoz0dXtZ8dZIp/QiVdV2dVP8A+tB/NutwNN
         lgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsnKeJmQAtc/gZyPzJxnW3mK4tSSagZHSdASGcv5jLk=;
        fh=pg255Pvgtdr6ht7A36Clgqm14Sdj3Wm7RulDFwK3qQ0=;
        b=K3tsQPUiQmcrtx0+I0cQDr8wecKw7W0hhRD9hVK9hDlXcustWDYsd642cOyFUK8pbb
         zt8Ccaw48dUBAKWQxgmEqMAEye1gQyA9be2WJ71BMpv+Fszfip0C4p+N9p4rsT9ytXa7
         yW+DLTetcTROP6TzwPow3nJv+FRLhVochkyECYvTdoHJe4T7vPggOv5nDZdkryYHUnp6
         mfLOaOkOtQn5VcAsg5FYepaMJ+qrp+PdFtTSP0poKDBAMg1poU7Pn0qHnqcbM5OSAM51
         1UYOpDzPAPyR7M47lS6o42qIaGMT20FLwNXe1WPNqWAYcYLtNNvhiWP7rt/dVfDGuZ8g
         74Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776667824; x=1777272624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsnKeJmQAtc/gZyPzJxnW3mK4tSSagZHSdASGcv5jLk=;
        b=NAPI9oSO89Byk1C5X/QrUxvUEBqcLvjAwMWUDwl2m9d7Qy9D37qlwhaKqjPeR6xLv/
         l8oIK/o4P2xdvyin72ZptJrSi25SSpPKWRdP3BxCyfO7vYWkEl51fAqAqJIF/IQe1Qhf
         vcXH1MRmobEzhHzQkYRSFuVA9YzMqv2o0L1XNso4/PcmnBInNVpcIpmpWqAOM/GB0KWI
         GR5RzUW8GebD2jACCkVH4y/Y6FvhlYYA2bZKi19Yez42KmhEMEAOANzillEwX+I4+Txf
         knh8oGHHWdFTwwHckPk752g+BtIyVZl8iq2bmDPMFXSOmOY7jp6wc1gotqHLRRNmMnkr
         bh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776667824; x=1777272624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsnKeJmQAtc/gZyPzJxnW3mK4tSSagZHSdASGcv5jLk=;
        b=IhF79d0C0AKuMqMyOxAujX/y2PhZcGPyNRoJgr+33g+0BjBUEliIN/17mpYjDgsVjT
         6XXb/JNk825EBpG4fnG+wS8myKHszYzDCFKm+qKWPpPnYd4evR+Iv5x9+4caJcSrwv4q
         Qx5z2Mg5Zw3FXEFAMiDglxd9g3JyoHNMpICPd+82dVP4iB/1DmCppSlXgOi8jZJ1EZoF
         uixhL4+xrRFfdC/GnM3q4jikvakbnwF908BZ/oR0e1qjeLJW9/30GyIxND8JKe5kPGsG
         zm3jfaPoScvJBwO+Xs35jHV7NYNUU7ODwfKM7bRgsgI6i8ZhVO4Q4xeMe2z2Cju/1Iu6
         YRSg==
X-Forwarded-Encrypted: i=1; AFNElJ9iXxgvq8F7mtn1NMPqClrX+o2d9DMRQfkzEzjy/jVbPdVg15ijT3E1B9sQk3aYshNmn6McCzJgGhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxifOYWoD5rOyaOSCjEG1o+/jv/93pa6CRw/ip1Rl8DD63FwC
	F8ttm45kd6hk9Rh8XHoaraCbUe14S/AgPjlvHs5hmnkr5ig1ooJtgZsGFv1druwiwK7BZoj4LzU
	K7/PWeNNFr5ogYjMLlxYSahfr38XiVoD0XX4d
X-Gm-Gg: AeBDieu3vHjJ/J3Xbne41ldMFaVAzOqW55S7OYVsi4uazVyWa/opYIBYpoGighh+nsb
	2ZJLTm989mimOucj3nObz2mlDRnNElEJ2fqKeO6vZHEps1wQeGc5tgh77dhKII2YztkcdV2/EOE
	A3YoTiV4N+OytIpQTgB3COa8rKqYPpHfYZhnbpMz5fq0GWYPjWBoTB5DTU6nawXCIXvalADinmq
	7YVhXUiT5upy5jPfxQyw4U79UYgng4RKh9QKQWLSVLaXR/5uEyHaytOWzTm28lcE5m6KXUeDCnM
	sMkaiKhna0LBZVGoHjHcUgX+gtjAt6yyOZCH05GMQHH4lrqq/5P22ltKr7/D3wGb2BC5qXBw4NM
	FCY3qDHzByjowCzlG3Q==
X-Received: by 2002:a17:907:3cca:b0:ba6:a05c:ac26 with SMTP id
 a640c23a62f3a-ba6a05cb61fmr199462466b.7.1776667824307; Sun, 19 Apr 2026
 23:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415032753.6006-1-rosenp@gmail.com> <aeXEIDgjTExt_hgs@lizhi-Precision-Tower-5810>
In-Reply-To: <aeXEIDgjTExt_hgs@lizhi-Precision-Tower-5810>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Apr 2026 09:49:48 +0300
X-Gm-Features: AQROBzDSwLSrzY12rpd5iHavmMuIpIkb5vhZemtYJ92PlxSc_wMPr-lqUREJf54
Message-ID: <CAHp75Vfp=Wvtq5EFM2vOZUfkGDcq_m_zpK_px0BKTFiiR8EwwA@mail.gmail.com>
Subject: Re: [PATCHv4] dmaengine: hsu: use kzalloc_flex()
To: Frank Li <Frank.li@nxp.com>
Cc: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10031-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC0F14277CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 9:14=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> Subject
>
> dmaengine: hsu: use kzalloc_flex() to simplify code

Not really. The main point is to have source fortification being enabled.


--=20
With Best Regards,
Andy Shevchenko


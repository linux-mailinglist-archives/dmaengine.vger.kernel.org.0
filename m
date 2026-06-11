Return-Path: <dmaengine+bounces-11438-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uznhFiFJKmpolwMAu9opvQ
	(envelope-from <dmaengine+bounces-11438-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:35:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A581866EA53
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:35:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sPKigTdd;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11438-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11438-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C9C3196566
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABBD35AC1B;
	Thu, 11 Jun 2026 05:26:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E335E95C
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 05:25:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155563; cv=pass; b=RMI5Lt7HfRIO8QqzjuCKbagxJLmvrlEB7PYzwUn7TpCiy9LONuIHe9fFFsJI27s/hrsRoSrG6tj2F46QFFoBu9zUeU3Nj98kvWGEwJcWkhfiEd0ie7v56ZwML9WSZPLevLaKXCmg+bhT4nc4F+uMw8knxwI77S/nWgF/SUJMgZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155563; c=relaxed/simple;
	bh=yewVEV8mlUGFdLcBpMm4MmbIeDvuGTwVVWyGQWUejvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsHICu2ugsWO9+t3SE12FE66HlHRKBRRLyAmdDS6ooU862EignbwpqSR6k8eiae2CwINHbOuUmDJjWVBz8X65ZrVXbyYMmw5BngddWh/HibgskecawWdwsmEGDOkSSvRtckcqeYvcy2wd9UdDNJFUSaqUKFb/1er5MxoTswv4uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPKigTdd; arc=pass smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so10829693a12.1
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 22:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781155555; cv=none;
        d=google.com; s=arc-20240605;
        b=VZPHIx90K/SleJg0j/F5v7SKyMuO/LVKhZcYTVEPfaU1imKe/3fpt9adG3zyn7JULM
         0i3YhigmVgJ/tfnmrh9daubZ76WZ6mMTN9IJA7zWFhX86QWQX3Rx1fjscUALZpqGuXcc
         PvsJgKnzV3dqDSNlkQRmUenKS24nEdMzYRW9+Iy/HrvI0jWGSF0snFh52NAkgiYV0vG4
         Up+i/lrWFvqZZ4zoF3CUHKx/EkuvlPWERr4KEKX05QLZhQlqOni4bsLCYY0VfzJe1oLH
         MfHNYaBs2h1nhr01xN4yDatbPLPxNNxpKL5vuyWfkHd9f/ZuJBBLJ7ySfzWVR3h4Gmag
         TfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=grfpZ9fJlF+KenAVmG1xj7d33nzZPydMREU5I/BDOSY=;
        fh=pKeODssq16UDr1uslleWcs8HNtnUsdTq0itHeWeX/ew=;
        b=HUSYbQrDh0u27Cgh1P1p2JdvQ1z48/CGtWyAP79BypA4zC5Ttw1Db50e+VRaGn3FSN
         3jj0Rcbk2V5BqktnTxqjx0+n/SnO+4QZ8pZNdSsSiejc5aSgkuPbkA5xD4gGHSUFRw6q
         5lhniHo9girQawPZ1/g+XoFYQRQg/Zd6ZRN/vymGSik87Z2wcxPdCAGYvrj7Xcjawxt/
         U52O6DLam4wwFcY/S38W87sl9gEU0PSxU96CdOhszRqbBygQFBdceJGcG2GWzGa/Enog
         Eus48AiNpsJ3mfINnkoomSxGUDLr4yYFd5vVPwZp0xWADPhAaJDHNd5N0FGPKlYbdYCw
         6ibw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781155555; x=1781760355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grfpZ9fJlF+KenAVmG1xj7d33nzZPydMREU5I/BDOSY=;
        b=sPKigTdd2iyI3gMTHvz/oNAB3RfK2Hah7buzVIEpRbrR6UxRqczxSzzk5ot0/phxOo
         tJKzQhfqT96S8zza96SdlxBrgLEgr7XC80L3KUGQF9C67Qdn3TzMgVpfxvpal2njrBDz
         ZZLqdvOc63uO3CAlT3y89ZWCnmZrUX7R6twBvwcck4ymGX8zkvvCNLug1XchLq37Urm4
         1JVsKJn9xqE17guTRtf5F7NFZHjx2gtyQVKPvNvKFzElPITvga1LiZi+M58btWZ6lusU
         yfJllY017LE2lKVSWrAxEqpPG6JsV3fMqAGngs2L4KHUq/w2PQnY66/KVPqCqge2+4da
         JP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781155555; x=1781760355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=grfpZ9fJlF+KenAVmG1xj7d33nzZPydMREU5I/BDOSY=;
        b=RK2DGiaoqqkQgk70c2RXYHn9sTjc7gyjW64YrjyX540ZnBpDnGKtltZ8zbHgROnzAb
         yGJFkBewzJq6hS95fk8Lxh+NW5HBww1Gvwxqrm6xG2KqB3kSli8W0Ytg7ntQZ7zeJxHg
         EyI3ZMNIQp92STk3cAb0ebwNBRti7ysfd2t0uSYefph4m44zqJ0telYgQviViCcQeLHI
         HNjMfpSWNkjnfd+eyPYHbV9aquXZVIwXeYn4LrniciX+QfO6iuqw9V8C9a6fBjwD1H9j
         PF8X7ZsUuhzgJhjxzH2icXFJQfWV88EkbghFnRd2ZjHytFGQjnEvEo3ne01JUEaRqGll
         DFPA==
X-Forwarded-Encrypted: i=1; AFNElJ88M2ejLEmV6saZKx0XtQtqf7kWgAFdYehFbevJb7/A9q/Z1L2jIej8l54kAhj7d+hwq6uwNf75+Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVP+z8YxFaF6mUi51zf1ir1ndCy/ow5nkHWWfHiaUROvOyjDGe
	b7528fRUQE8EF6Uiy7B0QDjpTsoGbgmAj4YeSajda9bn9olHcaVFAYFca4tiNIXvi1X5lSmoQ8J
	/2yORvfG/oE3vu56ARO8pgDdtZZtIWyI=
X-Gm-Gg: Acq92OGEpSl/oykV+D8GB4Ac8T9xpnH+Pw3iPT7VpuemqEID4zUTYlFEBcmLSiOZFXv
	Cc9kzUfYAfHUTTX/v03ZFuC43xXBI96QZDtn69yNjEt0vgrWMSX0rS3ynPRkmdBUsRunyJNcf7X
	A8sTBLPZO6XOj5xPckLuK771sXAJCO+2gRiGa11f1XvNlakTkVVpSKLiZKxQltPsq5u5vE6NKWC
	H2ohvXdPXwfudYIfH/1DvJF920BINhRFUuFi+sqsg6FptSCmRA4PawfCOmgbUOD/9Pf8gROUXbi
	WslOpQMLsDXkV+nQLgU9lE+cps7V871v9wB2Hf3B0hqQMNt/TyRad65cDVq0U2Zp43bX2XOyTA9
	f4018jwBJTeO4+LYG5RsgJAHxgkZzfS3TrmJWNAA0c55o/7aNQsFGO54oyoKGXEhZZHEO
X-Received: by 2002:a17:907:c0d:b0:beb:b53d:4839 with SMTP id
 a640c23a62f3a-bfc87ff2edbmr36403966b.33.1781155555211; Wed, 10 Jun 2026
 22:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610065737.118211-1-rosenp@gmail.com> <20260610065737.118211-4-rosenp@gmail.com>
 <ail38Mx0r6cW_Wej@SMW015318> <aipExHHd1Lrh0xQb@vaman>
In-Reply-To: <aipExHHd1Lrh0xQb@vaman>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 10 Jun 2026 22:25:44 -0700
X-Gm-Features: AVVi8CdP5-5FP4s_8w6DOvTY56ZVqw5WmQfbE42UPxbraR8hLYq6bHuBOVuueSk
Message-ID: <CAKxU2N-zA=R18WTTaJLDPy_RsoJd9WS+Lcb7TcCwKTxUtZQWTQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dma: mv_xor: use devm for dma pool and irq
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@oss.nxp.com>, dmaengine@vger.kernel.org, 
	Frank Li <Frank.Li@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11438-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A581866EA53

On Wed, Jun 10, 2026 at 10:16=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrot=
e:
>
> On 10-06-26, 09:42, Frank Li wrote:
> > On Tue, Jun 09, 2026 at 11:57:37PM -0700, Rosen Penev wrote:
> > > Replace dma_alloc_wc with dmam_alloc_attrs and request_irq
> > > with devm_request_irq. This eliminates the need for
> > > manual cleanup of the dma pool and irq in both the channel
> > > remove function and the channel add error labels, removing
> > > the err_free_irq and err_free_dma labels entirely.
> > >
> > > Assisted-by: opencode:big-pickle
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> >
> > I already said many times, tag should dmaengine, not dma, all functiona=
l
> > need (), please respect reviewer's time.
>
> And the worst is that some patches frpm Rosen have dmaengine, some dma.
> That make me wonder how much thought has been given to these changes and
> might be just an exercise to push AI generated code into wild and see
> what sticks
sort of. FWIW I use hardware that uses this driver:

 37:   89345094          0 GIC-0  54 Level     f1060800.xor
 38:  174555038          0 GIC-0  97 Level     f1060900.xor

Maybe all of this would finally fix

https://lore.kernel.org/all/CAKxU2N9yHa7ia_=3D07Csa7dDsZxcbPMmGSZKr+UxRSWH1=
VpG1fw@mail.gmail.com/

who knows...

Anyway, dma vs dmaengine is the model being stupid and me forgetting to fix=
 it.

With other patches, I've gotten requests to try and fix pre existing
sashiko bug reports. I don't really want to but it is what it is.
>
> --
> ~Vinod


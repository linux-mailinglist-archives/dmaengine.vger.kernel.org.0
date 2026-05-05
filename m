Return-Path: <dmaengine+bounces-10225-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EHhB8pw+mngOwMAu9opvQ
	(envelope-from <dmaengine+bounces-10225-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 00:35:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9941C4D4663
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 00:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA8353062DB9
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 22:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F231B100;
	Tue,  5 May 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBo3qhCP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307F3093DD
	for <dmaengine@vger.kernel.org>; Tue,  5 May 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020481; cv=pass; b=IhqbBHQsKcgZIWM+CYIqLcnMeBTh+VgKZOYcei371YS9/ebCrLYbXVt05pakSjGLmPu11Tm/OFh848Ptq9/6E0fO48hM11Uhs+zdF5rbbLUzO4rXI58I5roHV7M2efwBJM1Nqq0QB3/vrvic6DV3RUzfMHB1xunE3/sSqPYiHoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020481; c=relaxed/simple;
	bh=3gST69s0wTz7R9Z0LdEF3R1iFoTSG6KYYyUCLH9AjcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbJXPZZj0e/OF155ySyhlWx+NVLcfGCKvbZUqvQq9ax6Xzd2Oebz6JotZ/QNoZTzEiU+mcb5iCo1OsvsqvgrxfkYDGqsn1XSua/aR+PNxo5J06vCIUlU4VrnXf2rDNKaWpR/64ihRiw/UE88wlCvYFva+oK6Mm7gTApMN9QQo7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBo3qhCP; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-393925cb1baso36580241fa.0
        for <dmaengine@vger.kernel.org>; Tue, 05 May 2026 15:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778020478; cv=none;
        d=google.com; s=arc-20240605;
        b=g/NDNrUv4hfqvn4vD7Sh81IRCCskEpEd+WwhWZ1bBASgz3afzOR+xhqrBfUHN3BqCb
         NzLyuWH2uwsZdHXifFEWZ8clx0qznH3UsqCcmGLOPrPIAcekmoLjtmGyQqN8j2AWjLKC
         blN0+UbK/e0eoMDtAmTdQFYsBL0VDwzypCmh3N5w7tMwdpA8WwuTbKfFddMIteTYSp/P
         uybzojFq3jn28/ySRChESSYQUgSELSnVBT/0r6axUSbebHRNAHclQUr5gZB35t/GeH7p
         HlvFixo8c8pbTZG1L+s2UIHjsDQrjV1KEJCRB+/yvmWp2o8zsvvZMIRrjIkqikfOBfDJ
         vrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yl/pxrdoA3PXFkLtCdodJK9CsXwry1hJmHTcWccL5uk=;
        fh=qxtG89+2UWnEjofvMAEOtgDEInST5xFDGDJtYQquph4=;
        b=Rv8kGnDyI8mKui2sot6ljXN7WQjcFGYvf7FV9aDUy6xLHuaz2ihje10m4Kvqh7AIhj
         6DHvZg/S+WApJe8FgBeGtbdLoiAi96qwvi3KhTRWGg9eDu+hoqMIQrNq/frufU/SQXrU
         Ic8LMA4rZL1AE5LyiDUD/KOst8QddyelM2U8odCGYnydpDoFq95oUGiXIZm2n126wl1D
         hXdER6877rsXOmCQG0FjMp6Vi0od1yU8vl/uW2saTvQJyfGttdlywfRz9KBu4Zfqf/Wx
         oZTzrNn3XfllPyupD3+nnZ2P3xTiS67DoDvvhvQ8LDWXgkb/AnCUrjW7MgGCi0tp3tVC
         fBpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778020478; x=1778625278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl/pxrdoA3PXFkLtCdodJK9CsXwry1hJmHTcWccL5uk=;
        b=XBo3qhCP9ezS1lwezzJM0MxtNvjpHxPwSerjQXDGVV78ufpMf9br7Z8OVooQo5qnzE
         WUn7YJJC+nhMhulerUuxWR05MTxJ52bP+zbMIP+5DEf3UuOnUfdCWSRxetUu7HqfF482
         y3hA8kX7KSl0gtCC8jwLSp4a+SQMqZVo04JKldZ9vfT3mbkJvia/KBtbCd4GwXZB/ZA7
         d/VlGyJM05SE4btFlNjmgjc02h60tlRDF5go0om2BXrrExJLCyBB6CEY3/cxilQx+Jq1
         H58fucwAYlDZCOlDC33Atfz/b8k7l8E4lIF9l//9O0+VyquGr4XBEytqMNw6NZlENiGW
         jewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020478; x=1778625278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yl/pxrdoA3PXFkLtCdodJK9CsXwry1hJmHTcWccL5uk=;
        b=JjMT45VsdB2/o3/+H6oBV3VytJZJ4XgIVVJtta9mzgNMo/U8v5wUPAycAUKKnvKrT5
         9amkpGcIY/xvhWqB2g1sYtmuhD2MesaRcB6h58m7wwP38rSRdFEQAI/gyZ94TUr5Uwym
         +AhlHWlNZLpnwJW/Aawj28qX9chTEmzbrj7b09xrCx8iysPt18pxjTSFpBmylWJe+njT
         hQrrSGJit/mFqNPDr67984ls2e6WszipqG5u2pWEr6bxD3zwZZyztu13+FhmELYxg2pG
         BKH+znX1lPdcUmwLyyPNK8aDLIEFwkUI7/+GhdWCGWI7QhIJToV1tFRULCKxwDcV6ghA
         jeAw==
X-Gm-Message-State: AOJu0YxgpsbcRm+hJOOZbkSOaDjnuZpnkHu0duPkpsTEfpTs+c5vVKhN
	1mUVfzSqZQS9aM/Z6ouLfr+WnNPCHCM2gC62rnXg2IC/hhpuZTd/eHO0TTEcgsDvaQVBJqQUJZe
	FGdnNVNI9axpF7CnAjIWXVse4yCMX3So0cQ==
X-Gm-Gg: AeBDieskVIJC/Vm2GvYzbOVwwtZlQXwQEvdKRpAr7aF3I7iaYXd0Ep7COOLDUrl3lDM
	Ube0a393/w7vePoUERvk26jgrMsx5mpxbg1r+MdyoqCdxSolc9aFAX5W63+1cnCx/5Q01EnoeBk
	9wanuDlnOoHkhAgnruTIrgfWsGSkeEGwmKayd77R3aJ85s4ceC+6OoNNcp+f6NZZDPse4X7huLb
	sxTKDAl6He3Tc7SQdCoNLNJSyTp0lrvTGs9EdKimgrxuGYCI+2w9sIknms/PO4ejHgR8B6QmDG0
	nQl+AEcFjkSayOT2NaYnBc4OFqoXfzv9lBCkpkplVrUWov/r+gCXuDdde/WlYNxuAnNA2MLxus8
	ghnf9Vtq8qh4hp/MDni9jre5B+8u74Fk+6PovLGEjw0S78NghTv4PzWeXukOLQ+9I+zd6
X-Received: by 2002:ac2:48b8:0:b0:5a7:4a60:1454 with SMTP id
 2adb3069b0e04-5a887ce6447mr132114e87.33.1778020478012; Tue, 05 May 2026
 15:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504031209.618949-1-rosenp@gmail.com> <20260505133254.c7kfeh62ujdl7y2d@cheek>
In-Reply-To: <20260505133254.c7kfeh62ujdl7y2d@cheek>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 5 May 2026 15:34:26 -0700
X-Gm-Features: AVHnY4KXABoRniqiGppL1EoLqt826uiWiPeFJ0NxMfxrB7bPLJjIT8a9pZ_CgoE
Message-ID: <CAKxU2N-fKtn7-On2e8cAC3=Bzv1gU+c=kYfGaQx3OSg6Okh04g@mail.gmail.com>
Subject: Re: [PATCHv2] firmware: ti_sci: simplify resource allocation
To: Nishanth Menon <nm@ti.com>
Cc: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9941C4D4663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-10225-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 5, 2026 at 6:33=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> On 20:12-20260503, Rosen Penev wrote:
> > Use a flexible array member to combine allocations.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Fixup k3-udma as well since ti_sci_resource is used there as well and
> > needs fixing up to use kzalloc_flex.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: add k3-udma fixes.
> >  drivers/dma/ti/k3-udma.c               | 180 +++++++++++++------------
> >  drivers/firmware/ti_sci.c              |   7 +-
> >  include/linux/soc/ti/ti_sci_protocol.h |   2 +-
> >  3 files changed, 98 insertions(+), 91 deletions(-)
>
> These files are maintained by different maintainers - Could you split
> the patch and send to relevant maintainers?
The issue is the change in the header affects both of these. If I
split up, one or both will temporarily be broken.
>
>
> [...]
>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
> https://ti.com/opensource


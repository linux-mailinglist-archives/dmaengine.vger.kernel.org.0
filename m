Return-Path: <dmaengine+bounces-10891-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDLfLBMxFWouTgcAu9opvQ
	(envelope-from <dmaengine+bounces-10891-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 07:35:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 388485D0DF8
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 07:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26BF33007893
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 05:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DB314A84;
	Tue, 26 May 2026 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZeGcnLF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCA288C2D;
	Tue, 26 May 2026 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779773710; cv=none; b=rH++ALKnQGMx90/t9l7+wEq99Q1QMgvsRLSp0SnWzfUPJeLYqFneJ7EAKN0JMqhU9IUu9tI1F9lCDGta2VTbaTHXogycSuK6pVfC+wFvZv7pi5iU55sGA4pIJWqRzJDgfuhgoXEfMnxRm7nFsX6HlckelQK3QPpNsKNBSGxplt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779773710; c=relaxed/simple;
	bh=BCZ2U2fo+yH+zZPLh+gZxROwJlkA/+J2mSkfKof/QbA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HDFyGNJGpLHcb/TASFwjB9V7zn8b0mIVfoPlJSFrlLFT9lXuAusAmkeCIQ6yeANJsBw5YeXoyBN9B62zSqIBW4rot7/wf/sjR6EU6T1qAW52dAtHmdwqyIzwRT5i2JcKvPtplweKRD87sCGviPU45SvTr6p02sIGHwnBNBPbqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZeGcnLF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5A91F000E9;
	Tue, 26 May 2026 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779773709;
	bh=BZeCFiWwomXsNSoC7p5OXyKFyX+acoYY9otOOgn2FJ0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=NZeGcnLFvKxmYXoy9mb+eGDs/eV9D6KkS6d2B7ZuB8Anx/O02L34gwFNZdAVS71TX
	 XTW1hnNcj4J56+d7gK8TB9YH6l/C2obr78iLkmzLBdm0wvMkFaF88R2eT2WIRmqkIH
	 Xxfgpsii4SR9c7k4uKh/acFZ0FQT7oVENeg3/o20veqXPIXIjA40GlDtDwfF/CViA3
	 65vPTnSawSXL6e0de5d/ANoutOuSivQPH8qOinWjntbcmMME5qw2ypDrCjkztDcRZe
	 jNEauHN4jBCD9pMPe/6PJVK7BQokskE24Mw5S5Du2jOCsXDiWOpAWZP/bE3/dcxGfy
	 2IP02AT77tIcA==
Date: Tue, 26 May 2026 07:35:06 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
CC: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/3=5D_PCI=3A_endpoint=3A_Add?=
 =?US-ASCII?Q?_PCI_DMA_endpoint_function_=28part_3/3=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <ll76isrjb62ieiz4vhn3u3upp46vnzed3slpqxnni5hymsc4mw@avbx7k473uo4>
References: <20260525063456.3317509-1-den@valinux.co.jp> <xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi> <ahQJ4kuaBKMhj52L@ryzen> <3dkicfydmrlm2i6ks34kwjdmlvb22ryftkfw2yj62o4rtj5xvl@f4gby5vlwtdf> <F31848F5-5481-4402-9B45-9EC7BCC8B0B6@kernel.org> <ll76isrjb62ieiz4vhn3u3upp46vnzed3slpqxnni5hymsc4mw@avbx7k473uo4>
Message-ID: <F8664D81-EABE-4E36-B0C9-2B0C7FA36DC0@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.55 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10891-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.738];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 388485D0DF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Koichiro,

On 26 May 2026 04:04:07 CEST, Koichiro Den <den@valinux=2Eco=2Ejp> wrote:
>On Mon, May 25, 2026 at 10:32:06PM +0200, Niklas Cassel wrote:
>> On 25 May 2026 16:03:35 CEST, Koichiro Den <den@valinux=2Eco=2Ejp> wrot=
e:
>> >On Mon, May 25, 2026 at 10:35:46AM +0200, Niklas Cassel wrote:
>> >> On Mon, May 25, 2026 at 04:05:02PM +0900, Koichiro Den wrote:
>> >>=20
>> >That restriction should be documented with the new NTB transport, whic=
h I will
>> >submit if the direction taken by this series is acceptable=2E
>>=20
>> This is easy for me to say, since I am not the NTB maintainer, but it w=
ould be nice if we could somehow come up with a design where we don't only =
support EPCs that have 'max-functions' !=3D 1, because IIRC, most PCI EPCs =
have 'max-functions' =3D=3D 1=2E
>
>Yes, that's fair point=2E As a quick check on v7=2E1-rc5, among DWC-based=
 EP nodes,
>only 6 out of 45 set max-functions > 1 (about 13%)=2E Assuming there are =
no cases
>where the hardware supports more functions than the DT advertises, that m=
eans only
>about 13% of DWC-based EP instances described in DT could support the "NT=
B
>transport backed by PCI EP DMA" use case=2E If I also count non-DWC EP no=
des, I
>get 15 out of 64 (about 23%)=2E

The only DMA "backend" added in your 3-part series is the eDMA in DWC-base=
d controllers=2E

So if all three of your series lands, then 13% of the DWC-based endpoint c=
ontrollers can theoretically use this new feature=2E


>
>If supporting single-function EPCs is a requirement, then the separate PC=
I DMA
>EPF model is not a good choice for that NTB transport use case=2E We woul=
d need to
>keep the DMA delegation metadata inside the vNTB function, or use some ot=
her
>single-function design=2E
>
>That is basically option 2 from my earlier mail:
>https://lore=2Ekernel=2Eorg/linux-pci/xnfnxv64hpil6if4ikyohxnarvsekbmjcc3=
7k5zej264ix46z3@qtu6xj2uy3xi/
>
>    [snip]
>    2=2E Treat endpoint DMA as a first-class part of vNTB=2E The RC-side =
ntb_hw_epf
>       would create an auxiliary device, and a new dw-edma-aux driver wou=
ld create
>       the delegated DMA channels on the RC side=2E
>   =20
>       [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
>       https://lore=2Ekernel=2Eorg/linux-pci/20260312165005=2E1148676-1-d=
en@valinux=2Eco=2Ejp/
>   =20
>       I added an ASCII diagram for the overview as a follow-up comment h=
ere:
>       https://lore=2Ekernel=2Eorg/all/sn67hi7kljh7cgmgodatb3naz2astlaklq=
fobdbxyyzgoohxqb@4nnetbhqwba4/
>    [snip]
>
>Do you prefer the vNTB-integrated model over this series?

My take:

I do think that the design in  this series is more elegant that the vNTB-i=
ntegrated model=2E

However, if the design in this series only supports 13% of DWC-based endpo=
int controllers, when the vNTB-integrated model can support 100% of DWC-bas=
ed endpoint controllers=2E=2E=2E

What good it is to have an elegant design if in reality, it supports drast=
ically fewer SoCs?

But please don't listen only to my opinion, Mani is the maintainer, so it =
would be interesting to hear his thoughts as well=2E


Kind regards,
Niklas


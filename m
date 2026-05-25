Return-Path: <dmaengine+bounces-10886-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C5aJJeyFGoHPgcAu9opvQ
	(envelope-from <dmaengine+bounces-10886-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 22:35:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EEE5CE8E7
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 22:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E11E3024F8F
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F7D3A9871;
	Mon, 25 May 2026 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQXg9+0g"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC839C63E;
	Mon, 25 May 2026 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741131; cv=none; b=DloYS/3KG5hl13BLHLQX37gwO8ppMIBfl06WUFk10ClyudSc804XKpSa8MstzRHKwXuLAe5DiRFan6utsYdCFtJ+BqeSiDEIGV+8XrxMRdmfpsr6KcQxlVpFcqpif3j2iD9VvLKDK0rIoI6zQMo431uWNvdUPjus1Yxbh+eKFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741131; c=relaxed/simple;
	bh=h3kNNf9bQmpIEMHsGOEF4OitjEbuQUeFi9LDNYzBmc4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nzfyQqddWShi0Ds/Y0Rby2pRA1kIOgu9BBt+54OqEkgXKwI4YuDJts3KVyLr/5/EKZqWQ7Xd7UpsKmKybUJcf7ZQIWLxA7TKWvdgiKMoIVlM2w9Zolc7kXs7Sm4n0PleqIykSvOGTJ4o9Zj7abYE3DhBrzGhMXLUK7A2aYswPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQXg9+0g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339801F00A3A;
	Mon, 25 May 2026 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741130;
	bh=h3kNNf9bQmpIEMHsGOEF4OitjEbuQUeFi9LDNYzBmc4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=OQXg9+0gBgVvIfqDGCcwOipVvzHltjs1bqpls3vPAz8N44CvRFNDtNwIu9hXODWgr
	 k7vkypfYfp0ftClTxflM7Xl3RmPknAACAwXkRPXpzN9hgYQ9XWWxo8GkTQI3lvu76D
	 kB4K7UxIvXuEAMZc0hC7zird+pw4vlZ92t9txln80Wi5NfjXZh6Edg34Z7QDv+Gh/r
	 Ro+97wk90VkdyixHl01L4LGYTuErJXaBbJJ1Du0NJCseYZ8qu0gukwI0/79VdCUkm3
	 TD0oWz8vnd7XC4N7wX8xDwuClwCG/2aNISAwHgz/P9BIuPI4khVX9nEWhxuWDStH7S
	 R3DCHRFBh0rgA==
Date: Mon, 25 May 2026 22:32:06 +0200
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
In-Reply-To: <3dkicfydmrlm2i6ks34kwjdmlvb22ryftkfw2yj62o4rtj5xvl@f4gby5vlwtdf>
References: <20260525063456.3317509-1-den@valinux.co.jp> <xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi> <ahQJ4kuaBKMhj52L@ryzen> <3dkicfydmrlm2i6ks34kwjdmlvb22ryftkfw2yj62o4rtj5xvl@f4gby5vlwtdf>
Message-ID: <F31848F5-5481-4402-9B45-9EC7BCC8B0B6@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10886-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.814];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email]
X-Rspamd-Queue-Id: 36EEE5CE8E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25 May 2026 16:03:35 CEST, Koichiro Den <den@valinux=2Eco=2Ejp> wrote:
>On Mon, May 25, 2026 at 10:35:46AM +0200, Niklas Cassel wrote:
>> On Mon, May 25, 2026 at 04:05:02PM +0900, Koichiro Den wrote:
>>=20
>> If so, but do really all endpoint controllers / endpoint controller dri=
vers
>> support binding to multiple EPFs?
>
>No=2E For example, R-Car S4's PCIe controller supports multi-functions, w=
hile
>RK3588's PCIe controller seems not=2E So with this scheme, RK3588 would n=
ot
>support the NTB transport backed by PCI EP DMA=2E

I guess it depends on 'max-functions' being set in device tree or not:
https://github=2Ecom/torvalds/linux/blob/master/drivers/pci/controller/dwc=
/pcie-designware-ep=2Ec#L1365-L1367

AFAICT, this value depends on how the DWC PCI controller hardware configur=
ation=2E


>
>That restriction should be documented with the new NTB transport, which I=
 will
>submit if the direction taken by this series is acceptable=2E

This is easy for me to say, since I am not the NTB maintainer, but it woul=
d be nice if we could somehow come up with a design where we don't only sup=
port EPCs that have 'max-functions' !=3D 1, because IIRC, most PCI EPCs hav=
e 'max-functions' =3D=3D 1=2E


Kind regards,
Nikla


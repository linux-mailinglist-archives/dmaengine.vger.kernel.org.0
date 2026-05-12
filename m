Return-Path: <dmaengine+bounces-10396-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7GeKELm8A2q79gEAu9opvQ
	(envelope-from <dmaengine+bounces-10396-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 01:50:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAB552B64C
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 01:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 164FD304DEB9
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 23:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD9347520;
	Tue, 12 May 2026 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLB4CYo4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C045A79B;
	Tue, 12 May 2026 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629813; cv=none; b=cSiR3irTalwwBmOWCHJ4RlUS+RLU1wIHQGnIiWMyj7mZ3SVvpiZTdrY1AX77PxOYB4xVofFTWswmjhjYJAJZVtZLSh3popAelkPbHRp2PMM9xCR3AtHyKhUfZcHbOxUPcl66Xmll32zymoxmZOFap3hMPgek8GLntP6Q/jaT720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629813; c=relaxed/simple;
	bh=D2Apb4mo/DjBMATLVGSmW8AQLQ/RsvYCHxwcl+h3Llk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9DCjIIN/pDBXLTQG1kjJPCDBIuGWCXxRo1ibh4P9yzwTZIaPAnYjZX32QQvjHHnt045jNvM2p39NUd0TehA9qufI/dtlMRYtG5z8GULezfjLgANwc8ks+WTx61U+r23YhT2wDAZVM2nMEMkUvlL5mEvq4E4SH72U9Sh/1fL+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLB4CYo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F769C2BCB0;
	Tue, 12 May 2026 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778629813;
	bh=D2Apb4mo/DjBMATLVGSmW8AQLQ/RsvYCHxwcl+h3Llk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lLB4CYo4qeILNpPhF8zqVYX5OA8PVvwLrUy1TXtrKlXizsRyBgFQB6VXEUMjH4dPR
	 KF5eJVoGmPa/+OfM9UDG/WqVv8oPz3R9v7QNRRZ9m7PIKHjwUSipuEd/quTe/IkPet
	 PwAViB5PesFY/0YUXxjfwaIDoLIGTXhG79diBd4jz7MsmgODmDnF73dx1OiWLF4bwB
	 G4VSU8B+ADc6d5W2WOi6+7M3L4Axh/rwQtMebCSu9EzHJcFDF4Fnc2WAdDs47I3gLz
	 prTQlIS67f9xVmUv3TH6t9w0B28q5AXYrARFd3VS266XoMiXXRnmeWFvqCzd0QkV8H
	 CJJfbETrt8Ozw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/23] PCI: Add SNIA SDXI accelerator sub-class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-1-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-1-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 23:50:12 +0000
Message-Id: <20260512235013.1F769C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 8BAB552B64C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10396-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] PCI_CLASS_ACCELERATOR_SDXI is incorrectly defined as a 24-bit va=
lue instead of a standard 16-bit sub-class code.
- [Low] The newly added PCI_CLASS_ACCELERATOR_SDXI class code is missing fr=
om the Rust PCI class bindings.
--

commit 5c21a6a19a3c154b4d13c65d1905d5ed4e273dd8
Author: Nathan Lynch <nathan.lynch@amd.com>

PCI: Add SNIA SDXI accelerator sub-class

This commit adds the sub-class code for the SNIA Smart Data Accelerator
Interface (SDXI) to the PCI IDs list.

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 24cb42f66e4b6..83ab3f27eb5a2 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -154,6 +154,7 @@
> =20
>  #define PCI_BASE_CLASS_ACCELERATOR	0x12
>  #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
> +#define PCI_CLASS_ACCELERATOR_SDXI		0x120100

The commit message mentions adding a sub-class code, but is it expected to
define this as a 24-bit value?

Other generic sub-class macros in this file are standard 16-bit constants,
like the adjacent PCI_CLASS_ACCELERATOR_PROCESSING (0x1200). Drivers
traditionally apply an 8-bit left shift to them when populating ID tables:

    .class =3D PCI_CLASS_ACCELERATOR_SDXI << 8

If this standard idiom is used with a 24-bit macro, it will result in a
malformed 32-bit class code (0x12010000) and break device matching. Should
this be defined as 0x1201 instead?

Additionally, does this new class code need to be added to the Rust PCI cla=
ss
bindings? It appears to be missing from the define_all_pci_classes! macro in
rust/kernel/pci/id.rs, which explicitly mirrors these C macros to expose
them to Rust drivers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D1


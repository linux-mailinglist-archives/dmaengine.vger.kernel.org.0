Return-Path: <dmaengine+bounces-12451-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IjyfKGC5VWoOsAAAu9opvQ
	(envelope-from <dmaengine+bounces-12451-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:21:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 054CF750CBB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:21:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TJgue70K;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12451-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12451-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D233040DA3
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 04:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0612848BE;
	Tue, 14 Jul 2026 04:21:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7C26FD97
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 04:21:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002910; cv=none; b=cCt1l99+1EiVm1/kUR6i8HyOaDaBakfEKqJW7hV5jq3Oo43asMD17elbTkEd12u8Q3DMDoJQyuMUZyDKTyOmwbjsoWfFRekK4J3fMrbpA0o3RK2GOov0vBaim3d9XSK+PSxYcxh5MVpwP1lj7edsLGqjeJG1qx8Wan2wr2u6fw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002910; c=relaxed/simple;
	bh=ZvI0MIGmDJbwgSRQLjXRlS53mk33v3+KpXL7Ap98yhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NtIjZU8SSU2sBjBzUmf80U/0wrxmk49YPmPCKCi1+lc2Xd1Aul6HpN4Sj+Ww5Fh+PSP3dfSdU7oneK8woqNA8Kz/rZ1KXLwZsAEZMONVHI8Bq128VZSNuk7vZJFVZQCPuboHkr8ePtwvHcaeKmrcfZq8jlIevefkH3lnfZmVq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJgue70K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7484D1F000E9;
	Tue, 14 Jul 2026 04:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784002908;
	bh=ZKagY4kpE58TAR8jWzDctMXII9x0SCAf95rVIWGuiXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJgue70K/Pop+iASjuT/ebuiR55JqHFWdsNNACwkr2xPG0UlTcdoZ5cOsJbrZ0SxZ
	 RYv2WdjytNCNt9S1aRdnQqp3KlbYFds0gxDM3VMrEapb/rC8v1ZCf+ddVex1/Xyo1T
	 uXI5hFICeff6WxeShoDTFSTo3WbNUYX3MGGHD5be0c8zEq+xoJwIK3naHke0g1S9cB
	 pPYLIVGbgFogiGDuC3+NA8FwtUTvbGs0A1yVmkakVk3AyTdiNbxpGaNPRVKUGSAtRr
	 y0i+wqGo8JRwJ+y5KuvXRyG0xKn9FVc3G0QaT11XMI+M8meMXOVPqVphUkfhNmpq95
	 XhikGaDkcPEgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dmaengine: idxd: assign all engines to group 0 in
 IAA defaults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Costa Gomes" <vinicius.gomes@intel.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260713-iaa-crypto-fixes-zswap-v1-1-65cac23c684d@intel.com>
References: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
 <20260713-iaa-crypto-fixes-zswap-v1-1-65cac23c684d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 04:21:48 +0000
Message-Id: <20260714042148.7484D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12451-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,intel.com:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 054CF750CBB

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] After a device FLR (Function Level Reset), group->num_engines and =
group->num_wqs are not correctly restored, leading to sysfs breakage.
- [High] Double free of `engine`, `wq`, and related structures in initializ=
ation error paths and internal cleanup.
- [High] Lockless modifications to engine and wq groups via sysfs expose a =
TOCTOU NULL pointer dereference in sysfs show functions and cause race cond=
itions on configuration state.
- [High] Unchecked array accesses to `idxd->wqs[0]` and `idxd->groups[0]` w=
hen capability registers report 0 for `max_wqs` or `max_groups`.
--

--- Patch [1]: [PATCH 1/4] dmaengine: idxd: assign all engines to group 0 i=
n IAA defaults ---
commit 62dd36d5ea20980d4a54ca9e9b685288c6ec2b65
Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: dmaengine: idxd: assign all engines to group 0 in IAA defaults

The IAA device defaults only assigned engine 0 to group 0, leaving engines 1
through max_engines-1 unassigned. This commit assigns all available engines
to group 0 so that the full hardware parallelism is used out of the box
without requiring manual setup.

> diff --git a/drivers/dma/idxd/defaults.c b/drivers/dma/idxd/defaults.c
> index 2bbbcd02a0dac..26ebfa2ca1448 100644
> --- a/drivers/dma/idxd/defaults.c
> +++ b/drivers/dma/idxd/defaults.c
> @@ -8,6 +8,7 @@ int idxd_load_iaa_device_defaults(struct idxd_device *idx=
d)
>  	struct idxd_engine *engine;
>  	struct idxd_group *group;
>  	struct idxd_wq *wq;
> +	int i;
> =20
>  	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
>  		return 0;

[Severity: High]
This is a pre-existing issue, but can this function blindly access idxd->wq=
s[0]
and idxd->groups[0] if the hardware capability registers report 0 for max_w=
qs
or max_groups?

If an emulated or malfunctioning device reports num_wqs =3D=3D 0, the arrays
might be allocated with 0 bytes, returning the ZERO_SIZE_PTR.

drivers/dma/idxd/defaults.c:idxd_load_iaa_device_defaults() {
    ...
    if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
        return 0;

    wq =3D idxd->wqs[0];
    ...
}

Could this dereference the ZERO_SIZE_PTR and cause an out-of-bounds page fa=
ult?

[ ... ]

> -	engine =3D idxd->engines[0];
> -
> -	/* set engine group to 0 */
> -	engine->group =3D idxd->groups[0];
> -	engine->group->num_engines++;
> +	/* assign all engines to group 0 */
> +	for (i =3D 0; i < idxd->max_engines; i++) {
> +		engine =3D idxd->engines[i];
> +		engine->group =3D group;
> +		group->num_engines++;
> +	}
> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does a function level reset fail to prope=
rly
restore group->num_engines and group->num_wqs?

When a reset occurs, the state is cleared and the counters are zeroed:

drivers/dma/idxd/device.c:idxd_groups_clear_state() {
    for (i =3D 0; i < idxd->max_groups; i++) {
        group =3D idxd->groups[i];
        memset(&group->grpcfg, 0, sizeof(group->grpcfg));
        group->num_engines =3D 0;
        group->num_wqs =3D 0;
        ...
    }
}

However, when restoring the configuration, the pointers are restored but the
counters are not updated:

drivers/dma/idxd/init.c:idxd_device_config_restore() {
    for (i =3D 0; i < idxd->max_engines; i++) {
        struct idxd_engine *saved_engine, *engine;

        saved_engine =3D idxd_saved->saved_engines[i];
        engine =3D idxd->engines[i];

        engine->group =3D saved_engine->group;

        kfree(saved_engine);
    }
}

If an administrator subsequently unassigns an engine via sysfs, could
engine->group->num_engines decrement below zero, resulting in -1 and causing
permanent -EINVAL for future configuration?

[Severity: High]
This is a pre-existing issue, but does this cleanup path double-free the
engine structures?

When initialization fails, put_device() is called which triggers the release
callback:

drivers/dma/idxd/sysfs.c:idxd_conf_engine_release() {
    struct idxd_engine *engine =3D confdev_to_engine(dev);

    kfree(engine);
}

Immediately after this returns, the cleanup function also frees the engine:

drivers/dma/idxd/init.c:idxd_clean_engines() {
    ...
        conf_dev =3D engine_confdev(engine);
        put_device(conf_dev);
        kfree(engine);
    ...
}

Can this lead to a use-after-free or double-free corruption?

[Severity: High]
This is a pre-existing issue, but is there a time-of-check to time-of-use r=
ace
condition when reading engine groups via sysfs?

The sysfs show function iterates through the engines and performs a lockless
check followed by a dereference:

drivers/dma/idxd/sysfs.c:group_engines_show() {
    ...
        if (!engine->group)
            continue;

        if (engine->group->id =3D=3D group->id)
    ...
}

Concurrently, the store function modifies this state locklessly:

drivers/dma/idxd/sysfs.c:engine_group_id_store() {
    ...
        if (engine->group) {
            engine->group->num_engines--;
            engine->group =3D NULL;
        }
    ...
}

If a user writes -1 to unassign an engine while another thread is reading,
could engine->group become NULL after the check but before the dereference,
causing a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-iaa-crypto=
-fixes-zswap-v1-0-65cac23c684d@intel.com?part=3D1


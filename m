Return-Path: <dmaengine+bounces-9500-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEk1Kb5OumlUUAIAu9opvQ
	(envelope-from <dmaengine+bounces-9500-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 08:05:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD732B6AD9
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 08:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C00A3057E8B
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 07:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D577368973;
	Wed, 18 Mar 2026 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dHIszTos"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C3366DC0;
	Wed, 18 Mar 2026 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773817434; cv=fail; b=GByTVBGf0s2+m8unnxy726dhEu/KzJ4mZ5cEswlreUzvYGk6tjCOZ6mV99aHD/JkNcWvFZs7p5slUoLjZyGizEm0ocznOYYfbBXrFfASZRh1wHYJ41FUuM9opnoNRZYaZjHgpMRUaMPDY21RDXSWbSIkrp5SrPPKqaihKbm7kOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773817434; c=relaxed/simple;
	bh=uTmHEZ2Co9oNAx1GL1g8VIlBl0z6K6JWalLIYG/tDxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ljwe5ktCSZriRkB4IPCNJKOqz+x+EruinhhGYyrcEQHCNSQRf3OkminNC6+35DAyqxpR/NKfpiwh7gsRIGrAochPrKTpneIziI7cwCPa5oVt4udKdlg1ztLG6yHO8xGVJOHk1nH9i7rPaNXuhzArJ6vuYFxh9FCfbx18mLcNAEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dHIszTos; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maF+hr/ES2uE9lp2L35ev7WacKV1V5GaGXKcjsaSxYMsDN+mpj3fjrhTyEXsWLR+FfVxwCeMNThR3ujtjc2tK2VG90Z7TF/+qCrzypuYxOtlJ6/KBAL5rINbObOdO7G8+xIHXdmzf2RGfgaPXpkdZRAU9F+g4xYvV+MqCXT7RJuTtIElL0wsVxPVuDT0qmsgWPA7KF9kJV5S27Gkm1vnsI8YqrZgvrd4N/JZsS4ijefhVEongd9Pf3QKm9sy5yeUMDWLo5lx1rKJQlTfzvCd+NI0PR6IIrkHNfEhzUSt+yN1gUkAe9GTMm1rqBxns0iBzGtXwiLMXl8GJsGIU6hW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yZVB9jaxmr2khuyv9pHfyYndCyCF2YMnqO086K7BV4=;
 b=by+4ZPCq6U4UEzAAxDXC9HHFTYY1RALAFXdgc8ZKM4iioTZVORxtdT+o3IqdZDsZPRikr8qj246SxNKeLyJncU03W7licBbaKCRIuYq5+ZUPsGZUd0veyEdDBj3cdEZ+WczN8s3W1TxtJdj/q0PhA19ciAalP7n+rDBJhhw0m3C+wEihUJxEN/nZfMQr6PZ+bnIYDuC/aj0vv0ZvXgZcbs8Ib3lFb98qqfXCEJQ0mHB4s/kCpMeYReyWP5dF9qVliZYavAZB52ixR4QGQsqCGBL2NA/KqRcvFuQkBJ3JzTqNd1yI/vuayJZmjSFvQe/MEIS1ZYxmwikpWPwku34Ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yZVB9jaxmr2khuyv9pHfyYndCyCF2YMnqO086K7BV4=;
 b=dHIszToshArD4wEnrB3zip0FPWBAe7BPVrb6ap8VIJjOzOI0dLTd3p7plb87Rt0pSOVYhovjGEWriTsq9PUczJym1WBBee1SeJeSEIR3sedYyX/PbcyilGM8KEZkEggofwAXp43hE4ZwrHl/60Yrlm1C0tOAXz2jS8VmgD/8S2c=
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Wed, 18 Mar
 2026 07:03:47 +0000
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb]) by SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:03:47 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode Support
Thread-Topic: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode Support
Thread-Index: AQHcsUjRM/Dpzwvbc0it/CXmLkvpbbWymKgAgAAWBZCAATjcsA==
Date: Wed, 18 Mar 2026 07:03:47 +0000
Message-ID:
 <SJ0PR12MB8113FF140838F2ED287BE098954EA@SJ0PR12MB8113.namprd12.prod.outlook.com>
References: <20260311111834.3750297-1-devendra.verma@amd.com>
 <abk04pkF4mOR0rKP@vaman>
 <SA1PR12MB8120B73E1F0B6BB8035AA7219541A@SA1PR12MB8120.namprd12.prod.outlook.com>
In-Reply-To:
 <SA1PR12MB8120B73E1F0B6BB8035AA7219541A@SA1PR12MB8120.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-17T12:23:20.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8113:EE_|SA1PR12MB6996:EE_
x-ms-office365-filtering-correlation-id: 166661b7-8334-47d2-a313-08de84bc802b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 +Ud12d3qySc4AJe+/QgYls+WNxRuhbZuUEiDq0zfw2tkr4CshXUy1HfaP32XfqKulktp3VBhUc8qp2x7cYqKUSS5blmLQ9f/b258kw42pLafPoCx68oCEYeeL10eYMO6jSdFGt3RI3CA1u9T2zg0PCovTHVKc6WEmrRV7xVOFmb+6PbEt00dIYUcBYhidXP17xgXknBp4Ko1u4AioyakQD/tt+xuEq+BOSDtDXxKEaDDcvinrnHgv8JWt3v2meCIvWyvldEmk/8cOc3TEDRMlF5cFIFcYLI1VM8heUvGmBmBFt9TQIpyYqR6KqocK0udC3xxm+PYTHkZynho+86SoG4zVdrS0scBk9AO+F3WVS4ll5Fb6f21+QB0EJ61j+/tvpE/NOLXBHI4ssAFITHZBfcYuUFzGLaMUAK09S3OwkSFzYARYcq6deiL/ejkIl+0ZHruSWYUVh0gJ5RR7b0HAAPzpAw5S8y9EZU2RlZP2pOljo5/ixKdumAN8Meps3ve4Lk+onve1aIaGVzABXhlMZrsbYDJg+sqMWJXlQ6zeBajyw3s3YM696fI6HUFo0EcDo7Ife0OYsfS4KfVmKwekzFSMTz8hSUye/D8KJzC5/k8mrwcEC42uFQlhBEGcbG+bRFm3MQi5faydANHtnHqsELUkZT1abwQjQH5mTx4x9S7tLVi8zV7U1aFQiDS+7s4yIRPwLbFNOKlnutYzNa1NM7N+ruLQjBS2Br4vfMzQ032WSuNJApklmG0KuZMKFwiCYklGCaNYYEijng0a3gguDZA3pmum3CW4IJ2B3yyxMM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8113.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bj+pacNE/F+oFXavaj4Cjec3qlOdnBYN4LUGuq2GLMfl6yPc3HOsqCaITBO0?=
 =?us-ascii?Q?5WVVix6Zq2kqMJ5Mh/VO0cXrmMMx2rs/R/F31eo1SD91nHUz+BrxeJ4pObWQ?=
 =?us-ascii?Q?poxF8yqGE6xJfDVCWA5Uz3Ef9kiFg4wc94Ah7vc7bMRJB4G6olrMKLEhrav/?=
 =?us-ascii?Q?vEUnbKwjFNgq3poCcbzsrRj2phrRqljqW0ZKNBSUYd2HLj627Ga/nh4PT5r4?=
 =?us-ascii?Q?eS09b3O9S3PFP5Fg3CZKnyzQLfeAPTX6XuHo69fLfR3FZzu3xQSuV4vBlLfG?=
 =?us-ascii?Q?P/a3lNori9aF3uukNbhtxvKgSQTV+BmEOtiLMQlzyNWGBEFvv+7OUJUmSsea?=
 =?us-ascii?Q?hTBeJmEeRAmGDy/IDBMCS/OXFZRStcTzm9HfB35YM2E2Tl9GZpRi3bhq3ZPy?=
 =?us-ascii?Q?Fcrf5D+khjEZdgFZEA2EPhQYbPHWtXrkF4sIjz801Xol4WQK7gQ8FsTHH1A9?=
 =?us-ascii?Q?l3l2fYZX5a5gbNH/n8yE4XjSSutU43sWYNJOUMVs2yyiQ58bVzumndzQ8r3I?=
 =?us-ascii?Q?RGhJ3HiNELgNZeiS5k3w5AkAZs4NNg+nuIANvCz3P/fBQ3LNaGNKbTqUykLu?=
 =?us-ascii?Q?OIU16N7J4SHG383BVFhQKaHq4hoQ62kSaVwlwnRUOXgKGZeQ5tA1KaR8ojz5?=
 =?us-ascii?Q?fLKQV2NzDQBySbg+2XJ1PEmuoMImtAi7dXm3S2cDs00SkKC28fuWcDekLQFw?=
 =?us-ascii?Q?x+PCoZdrtOWhZkPnidiZT8fTozOvyEk9dPwF237iR9H4oe+zJdhsNQ/zU21D?=
 =?us-ascii?Q?38c6zilZ7g/4uLuPpQdBDATZSvL89q/JLE/aaISGNNr1M3m18iLqbm4VfVJU?=
 =?us-ascii?Q?YTrgnuUxUlZ/nD8fg9qk6prz3wgx5TL7043ELAbwlHUi4sW63NF9JblSLqqD?=
 =?us-ascii?Q?4K1AdL9jh61T3kD3XIum4ElzjfH3jA1mnkDoCzv3hjiyAVM8jWV3sQK2PfTa?=
 =?us-ascii?Q?5ibSSrN08dm4jMmju/SHALUQ4eUVOP2VTmiJjToBgdp8mESJ0P8ZRd0VNZHk?=
 =?us-ascii?Q?Rez/9YHj5HcOs7y6dTKvssg3vXekUpDYXuCO4PEzPnSfbmUO089YPofjEYw9?=
 =?us-ascii?Q?F23lsutWpxXP8AMxJRbt3YDnToMH9GSdySBsOqRJ+SdyZZWxfrx2UOr4oXpk?=
 =?us-ascii?Q?VshtWnGJhsg6+9oRUnZDm7nqJpvpGY4p2C1nHZSy3gw96mRtG1ubEkBXZvbb?=
 =?us-ascii?Q?wLzX8fNQWauo3FyAZVePSjFbZV3ZRExkRgaUyGQT6xadM+uNN9zbLBQANHGQ?=
 =?us-ascii?Q?22Bkx4uu2CK3YTTXU9aLzq+sxgkIfxjerCtVJqc4fUbAImYcein4aIwt6Qa0?=
 =?us-ascii?Q?zI67ogD9BBG6RnHc+K5oUEKqKv7x8eOxDjD+G1daO6x/zPEMY/1cg5MLy2vd?=
 =?us-ascii?Q?i0YqDm9Eu0+qQclA7JGYAOdWzgA1JOAGH7wiPuP0QGPqgPXuHsKIdDBG50zr?=
 =?us-ascii?Q?IuRmIH0eM9dJ/zwqqMGaN0lszGHIB+gsz4O0p1IK/u/mYVDpg75NPSulwV2L?=
 =?us-ascii?Q?qhi/XPle7XwW+PDk451WEcAElQnT4cscTgbBgqQ8Ban5Keurl3eA4soOsRoU?=
 =?us-ascii?Q?WAusKGyN7viqMFRljOQm76VfNFpkKuSEhXvuaRQlSOCeA2ZvgOXwHaEcRYxI?=
 =?us-ascii?Q?aMVQQ2YS/oX2bTzQt3J55UxCBbHsNABeYdNVwU/PDJ2snl3wj4HrLcXmFpCS?=
 =?us-ascii?Q?QpZsFVU8sMf5X/M24m+CeElNOb5GCyQmIRdR026I23RytTnW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166661b7-8334-47d2-a313-08de84bc802b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:03:47.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18jRiRvMgCZgnQOehXXgPB57OWuhEKBLs1krWcGYPrJdG0eeWkSeAXBTmVevvxRvfJlqbyARpyxLPm0H35rZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9500-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,SJ0PR12MB8113.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 0DD732B6AD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[Public]

Hi Vinod

Please excuse me, I overlooked one of the requests related to rebase and se=
nt the patch (v14) without any rebasing.

I am sending a new version (v15) rebased and with the fix for trailing whit=
e space you reported. Please
check the latest patch series for the trying out the merge.

Thanks for your inputs!

Regards,
Devendra

> -----Original Message-----
> From: Verma, Devendra <Devendra.Verma@amd.com>
> Sent: Tuesday, March 17, 2026 17:54
> To: Vinod Koul <vkoul@kernel.org>
> Cc: bhelgaas@google.com; mani@kernel.org; dmaengine@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; Verma, Devendra <Devendra.Verma@amd.com>
> Subject: RE: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode
> Support
>
> [Public]
>
> Hi Vinod
>
> Thank for reporting the error. I have submitted a new (v14) of this patch
> series, please check that series.
>
> Regards,
> Devendra
>
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Tuesday, March 17, 2026 16:33
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; dmaengine@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> > <michal.simek@amd.com>
> > Subject: Re: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode
> > Support
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On 11-03-26, 16:48, Devendra K Verma wrote:
> > > This series of patch support the following:
> > >
> > >  - AMD MDB Endpoint Support, as part of this patch following are
> > >    added:
> > >    o AMD supported device ID and vendor ID (Xilinx)
> > >    o AMD MDB specific driver data
> > >    o AMD specific VSEC capabilities to retrieve the base of
> > >      phys address of MDB side DDR
> > >    o Logic to assign the offsets to LL and data blocks if
> > >      more number of channels are enabled than configured
> > >      in the given pci_data struct.
> > >
> > >  - Addition of non-LL mode
> > >    o The IP supported non-LL mode functions
> > >    o Flexibility to choose non-LL mode via dma_slave_config
> > >      param peripheral_config, by the client for all the vendors
> > >      using HDMA IP.
> > >    o Allow IP utilization if LL mode is not available
> >
> > There is trailing whitespace in patch2 and even then it fails for me
> > on dmaengine/next. Please rebase and resend
> >
>
> Corrected and sent an updated series of the same patches.
>
> > --
> > ~Vinod



Return-Path: <dmaengine+bounces-9159-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OIqGXAmpWm14AUAu9opvQ
	(envelope-from <dmaengine+bounces-9159-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 06:56:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 256911D34BF
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 06:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8843B300D1CD
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28833803EF;
	Mon,  2 Mar 2026 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H6kYlp36"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20452366055;
	Mon,  2 Mar 2026 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430952; cv=fail; b=IwcUhdaul8xDvdEuZUYy2PGb2fwRTzcXK6JT7F65lS5nKyjuOPWXsX4Gdf3wDPnSFDIsRf21dvrcV9iL8zUUTGvBKRVQ4Khqf7yHVc79sW8tYCnJTNUP0EZkOE1pGlsTTWh1YgYiwgtJQv/d/8NakfN1QP2lFFnQXeohS3nTG4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430952; c=relaxed/simple;
	bh=JD0hsVNT385GGX48UOv460QLoiydEDrzAwfbtqjzvEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WD6N4YuPs4pcjwxCt+xbVrG2DEoYHPYIu0y55G7+r3dhoMZms8lVc0v+EZcD4Fajg8OKnJWXqBf5wa+qmQ5GQEOtNzNCRaWbIjLqjV/jHC5x0cxwLwuw/NPA6rVx/E42OT9jbhxU89+qebfMSojAshHL52z1v1DIDyf4onoB/pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H6kYlp36; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqM/EgYpsth58kWdMk/IQNPTOsRLawynMnHkxdE67QM6bmOTVCV0pODQxV2cqcgnPcUZ0F6kfooo2Ct8JP3gw3+NheuTq3wgDu8aAUtIdWjJ1iYkMySYMcawQgMJeGhvNqP/rAc8CufijSMtTx6WvAMl2cvirmSaKEKMVdHpEB4fnl4BEBDVWTRjWxV7CQDQLTsoYAt0UTza7zTIH94lZd2+ZO21LvllOEgaEGVIhHq+SBAfqOJ/qa6a768jYmRDmQHwD5eQzDwrdeD7+jvK32dpoAIROiXj50p37T4MUd5gHs4IwlynWR7rSzdLk4Vx0gfOC81ExUctn6s65AyBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Xxv8Ku8w8FshHSmCpl/jcNgy2dJu2WFk4xwhvOgSWc=;
 b=dkDuRooAv5o24fh2M1JDfoAePctiTetVy//hs0QsDbVVmLP4TrfDdMAX1gKKi9Sce0wWVj16qNf4B5rqma/67PREdBtKmRkGXO+EsKG7+PEUDD0GcrQ4sT9sSKsiNSospQSCuhjHt2WGCl7J1AzqHN/wyu2RnQtkSe3urswmhYrO/p6OVYKl2NJlCPeaLYXcC9vXv3V4FYBH5h4DqPEvWjmGS+dYE2VxLkb13fLOdtAOzMq3Kkv6cDt6cTNJJKifRERsRcs32zn7+Ur0GHjZhs0RQZKwdVjMR9Cxt1P6RVWjae1RXwT1+KnUy8f/b/awXT3ZWklg5kw27XE9OemzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xxv8Ku8w8FshHSmCpl/jcNgy2dJu2WFk4xwhvOgSWc=;
 b=H6kYlp36j4/RRW4taelxfMpLsF37kEHNEE4TnHcxetRSXvnPBZjdvz71P5Fe2DYOYKa0Ly2Oz1qwoVZt2DIXT5gOnDbMVTqS7vfskBcvgp3e7Du9jGXJm2Xtwpt3GSdpAvz7gDrZkuy8Vp+yq/nDMeXNfSywm1lglMJZqLTRuYw=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 05:55:39 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 05:55:39 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index:
 AQHcnzLWCO8+PlOBsUyeigW/SoG/H7WFuzkAgACmYXCAALfggIABEsjwgABxvwCAAOnmsIAAvjoAgAEKjvCAAHWzAIAEwNdwgAHz+ACAAMV0oIAHkzFA
Date: Mon, 2 Mar 2026 05:55:39 +0000
Message-ID:
 <SA1PR12MB81209A9579FB1BD980DB8004957EA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZ4l4IHqObEP8DfP@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203E3A32F0670DB15D63059575A@SA1PR12MB8120.namprd12.prod.outlook.com>
In-Reply-To:
 <SA1PR12MB81203E3A32F0670DB15D63059575A@SA1PR12MB8120.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-25T10:14:27.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|DS7PR12MB5984:EE_
x-ms-office365-filtering-correlation-id: 4fc568ba-e5d3-4ce5-42ca-08de78205550
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 HKPjaGV7qaI3BKaO9Tro5atFvzOsGjTNDGrf4LjSz0WcUa58Sjj7vKMT2PwPnQH21nkPYB0MHa9adJKSthoj50NKR9PisArSCk4idIQtSi3HHD+zXqkncdrSCCrTeSZTmatxwNUpFqUcSc1DCvwcPoHdv9YGmOhoZKU3gcvZ8zsPGDvqq4ieMiaFM6THVhPdX3qYWBUs2tSu/zI2to4aW0JXEtSBRBLxFBShlD/BiPMv2JRVEUW2cDoKudRWHJ5ZkOe6+Q5IzTR5HqqbOnRyNjEekHDHSjocvozRXZknyMPeZMUzQo9GRyFYLU30t5kyz3gJ3RJiB08J2rw3FwA+hQZwjm9DyJ7gpc9nyyRrvCzOFa3ZITTzETVeE+FZkxXDnpCypaZ/Zuy5FYEcH7Yx3/oug5pqg9pYA+IBQrAviNPTNr8tY1P91KOQsyhGV3mR/QuIfxpZHdBBEOtdsDhYLy4yF/KqGGutPJTWOg/FVzyNATz/YeiqDXsHx39Hz+vWlsHy/hbo3eci+vSaGpsyxKPb4+NwtyT8EeF6g2OxcULTfJSFcgodJ/arR93zB8/Ers38KKMI3tgkKLYOqWcDYdCiFUMFR4kOCmdAarUhdhS3dUQG3tOOWgvCHhWIG7NxuiMpfcLlUoYL64Xri/ApLW2I+C/F2dmYj3uHY5dX094yjB9JdZeWGI1wEL9ADgr84OR23icfjb0ihZO8KZLZE9et7q/ZZxp2hB5WbBksdI660AIQansAfQE2ZfkJXxTIcjwJnJqbve1/susQdPQcomvWtxaDJn0+qr7Bnbxj2Sw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wI3gpqat/KmprMTv15MiYNtjgYZsmU8QRU0ves4pl3s5snrMTR+2ZbabOTtI?=
 =?us-ascii?Q?6TZGQUw6CrvFzEH41DnviDSK61mrlvk8HyDlCGrGiyDrONzwEl/6h1yX76/M?=
 =?us-ascii?Q?P90WRkmru6LC1JE4scLPaWq4rpIRTRulBhCR5YSUdNY1Z/ItJY9Hg8bV2px/?=
 =?us-ascii?Q?Z8OChQl9JDO7TgQ7Nm8tio9RwDw3Mg8n4vhxfwpL8H1yJIYjqOd4eSuIg4oq?=
 =?us-ascii?Q?+DCeTlAWzcIxNFFIttKt7XZcAkzhWAFfmihF3pBKJDkt0NS00KkQKY3uotAB?=
 =?us-ascii?Q?jo/w7ufK4eaWwoVBewVrYUYsNhBdrqXzao3YHeyLouQf7yTQzxwh69ZFd3eC?=
 =?us-ascii?Q?Vut/zHTum5ODghUe+wOh1bZkytZYUuSNGiL5xdIsvqJzJi7igzoGaDviXTqR?=
 =?us-ascii?Q?+XD4TUwTSxVMbDJI0Yt4d+r9Wwnj7v3AYij8JNHYtT24nIxzv+7AT0NMbTwW?=
 =?us-ascii?Q?t6YfqiIN8ndi3VkaCTN3AGPLPTKvQNA2M5357TcdOq7GD41KS7CjvSBpbCs9?=
 =?us-ascii?Q?murj469a4ndCA8CFPq3lOJblar084hNzQacs31ulAwqjcA49dmCh13AmiswU?=
 =?us-ascii?Q?DOpBddcVtMm+9Xt68vHHxWOQczQTlVBrhB4T/ln8eYdtChVt1vMWRuOBui08?=
 =?us-ascii?Q?WiIhwoAArYDldvhGV8Fchw9l7zx2YpGiN2fC3DjcE8Wc8dic+g8evsLg1zN0?=
 =?us-ascii?Q?bt83+iUZTMcdLQLi2dhMLGDdpQe9pw1nkB3j/6UwE14LTT/WSJVhGnLENn/k?=
 =?us-ascii?Q?Y0yFwuoUvB+/5fo9iESTAnbUXBraa8XqGd1mqk28a9p+gLphYdCTw0KPxMae?=
 =?us-ascii?Q?mdVdFpjYbGBW8KBh27l45G3lkiABFzKMMOQg86AjjOiv4GeZPXRY6SLfvS9/?=
 =?us-ascii?Q?6ihmOLuSddPtHeyhdyLRWcxPUnullDOx24Zdu7Q1D9DsYjuJpkMx0v9eFkLw?=
 =?us-ascii?Q?PvFkYiHBYqK6bgOzkYSsMSB9eznlej569cNRsVz28dJq7oVlJqCBZndVAamY?=
 =?us-ascii?Q?PXcaWEEtXT6GImzUZUsayfamH3SQNskQ1UuoAGsEvqN5HAUpRn8llL+UhKt6?=
 =?us-ascii?Q?jqeL9ZUnyP9ztTjARAENFoV2P81ObAdoMkUHmJ3kMEIYI+JMcbLbwP83bDSL?=
 =?us-ascii?Q?gzttAmxMCleFFTwsP6xT+BCIj931pDZm02VJyjEDYuVlzb1a5aBC+o0l5CXF?=
 =?us-ascii?Q?w2IiucxUAukBFpvF8NfFmvDVs0nSSziRcytA8ev27SCXMWoeXyp668diIy+h?=
 =?us-ascii?Q?sngO3IJDRUdVf+GK17gpGyAvQhfZ2bcpAhJmxfwiQkvEaJdlpglLqvtk2Rgy?=
 =?us-ascii?Q?Fy04IP/XHiPK3ajOYrWQSZkYzNkp7SNXBeEBEi/QYGyXOGn0wB3HJ4EJuvL1?=
 =?us-ascii?Q?YY6ddfNvzzYjeWVt6Yl2iP9lHFplBb9t1kQjEo+/cIhsbEj0iIcLzYIGBzwl?=
 =?us-ascii?Q?UcaPR4R005BC0YE69J+KGy0MBKvyekPTagl7ryGO7HNjFjxOLHbYoa4DSKFO?=
 =?us-ascii?Q?mz62AqUaFOpG3V3TXm8lDHw8+Dg5zpSK7My3TPASdqRQ7FdJtuhaFECoGQzd?=
 =?us-ascii?Q?8dd9POCKueKNGvOG4355VFWdA1uVDGsB67L5QR/FEP5rqv1TAxA1DsaWJjp5?=
 =?us-ascii?Q?e2cW9A1dElEo+p08TaShgB/EpqIBnIKIhm6fdUUXXPotUzvt9wPq7sOlnv3H?=
 =?us-ascii?Q?e3A3NxdzMigV7z/jbsY3kGmwT18Dm1tueqeyTO6rS+drb2FS?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc568ba-e5d3-4ce5-42ca-08de78205550
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 05:55:39.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDZp+3C960R9aL/tsCo91PA4WScrXHSssKjyE1VCPr6rJwXRi1aifv+Ui6P2C1g1YeFv0yuLdvFyXSX2lxJ/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9159-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 256911D34BF
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Frank

Could you provide your inputs on this?

Regards,
Dev

> -----Original Message-----
> From: Verma, Devendra
> Sent: Wednesday, February 25, 2026 5:36 PM
> To: 'Frank Li' <Frank.li@nxp.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Verma,
> Devendra <Devendra.Verma@amd.com>
> Subject: RE: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> mode
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Wednesday, February 25, 2026 3:58 AM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > mode
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Feb 23, 2026 at 04:40:07PM +0000, Verma, Devendra wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <Frank.li@nxp.com>
> > > > Sent: Friday, February 20, 2026 9:33 PM
> > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > > > mode
> > > >
> > ...
> > > > > But if it about writing a new function to check the LL mode
> > > > > support then I think the current variable is good enough which
> > > > > provides good readability and do not create any ambiguity
> > > > > compared to the ll region size
> > > > comparison.
> > > >
> > > > It is not big deal,  use 'bool cap_non_ll: 1' in dw_edma_chip. So
> > > > we add more cap flags in future.
> > > >
> > > > Frank
> > > >
> > >
> > > Hi Frank, could you elaborate what you mean by adding the cap flag?
> > > How it is going To help identify the overall chip state?
> > > I do not understand what is being implied here.
> >
> > non_ll in chan means current status, which indicate one channel work
> > at non_ll mode or ll mode.
> >
> > here dw_edma_chip means hardware's captiblity, indicate if hardware
> > support ll mode.
> >
> > Distingiush hardware limition or current working mode.
> >
> > Frank
>
> Thanks for the explanation!
> Hardware supports the LL mode / non-LL mode, just that there is no piece =
of
> code available which can perform the non-LL mode as only one mode was
> supported initially by the respective developers.
> So, providing it as capability does not look justified as in any scenario
> hardware is capable of non-LL mode. Theoretically, non-LL mode should hav=
e
> been the default mode.
>
> The non-LL mode is not a hardware limitation either. LL mode needs extra
> configurations and in the absence of that, interpretation could be, enabl=
e the
> supported other mode which is non-LL mode.
>
> With the current non_ll inside the dw_edma_chip, when non_ll =3D false,
> indicates It supports both the modes LL and non-LL, but requires user inp=
uts
> to enable it.
> With non_ll =3D true, the dw_edma_chip or the hardware has no choice but =
to
> work in non-LL mode only. This is the interpretation for the flag in non_=
ll.
>
> With the capability, would it not make the statement, that if non_ll =3D =
true, it
> supports non-LL mode but that does not mean to be mutually exclusive and
> not support LL mode at the same time?
> If there is a requirement regarding the capability then it can be taken a=
s a
> separate update but I am not sure what purpose it can serve wrt non-LL
> functionality.
> Please let me know your thoughts on this and lets conclude.
>
> Thanks!
>
> > >
> > > - Regards,
> > > Devendra
> > >
> > > > >
> > > > > > Frank
> > > > > > >
> > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Frank
> > > > > > > > > > > > >  };
> > > > > > > > > > > > >
> > > > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.43.0
> > > > > > > > > > > > >


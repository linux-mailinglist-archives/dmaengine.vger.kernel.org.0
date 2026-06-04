Return-Path: <dmaengine+bounces-11162-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yPf/FhRiIWrqFQEAu9opvQ
	(envelope-from <dmaengine+bounces-11162-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 13:31:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6063F701
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 13:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=lUiF2qVo;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11162-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11162-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C2D9303F061
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2803A413D8B;
	Thu,  4 Jun 2026 11:28:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB155381B00;
	Thu,  4 Jun 2026 11:28:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572499; cv=fail; b=I79zxVpV4Xdc5uClClKIYUMOWCR1a4lW1Ws1NItsPB5HJKxz2BpqCdEqngRLAd7ZNsfCnsqWLbQQDYslVoMw37YaF8kmDIusNZWfJApL+vWbVk5gH5i80wYWCpi+9JE6fQSVzjnnvWZcI8A0Yz7aP2d7UaQDPO9dB/Y0bHawvrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572499; c=relaxed/simple;
	bh=qNU2yJmUip0nN+nPRsTy4FkxvSswBTpicBUnYHtinDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aAh1zNsHgJA4U/5nvjXvj0F8M4VS1djxsBRa5ScW7ndREvwbEVQoXZDATQEyL3DyDfFO2qx81wV6xke1d1Hj+A76U5v9I6a4XxaFyCdPpgm7Z55ggHsXdfAAfPes+L8XKZ0brY2JWyPYyfzRj7rpCzr3qIoOAbGmm4Kd6Ygt8ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lUiF2qVo; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1UYeDNxGgvnS/37c7TQ3TQyHTYSwIvK50buRs7FptCWN1kmEKOnH0gxtrvvDJcKAPVPtwi4o7UZwMN/3pKty4okKl5yvsF7nw874+RugwsvwDu0HxHWTVoT+6JNmlcGDea4AAoAOYSVAcmFehbm/XCWwHL2UXTXS9NqLVK0gs9Z9pdtaKSCO+z/PIYMC6cglkJVC7RjH4+XfGXyjktjQLqW4SWWgABJWOz1ug74vmfZNkEWsUoCP4RxlitkDj+m19MUvPf+dU8cPAgqzbz6H9hfamkl4/Oqv7wDEBjGx20auoTnYoaVgi6r2Tcqj1Velp+TjvtkIkzBAXgpGfManQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SylsoA4Fvi60Qx5Ep2DqkuT5kdRNPUEYSTOepUZHcAs=;
 b=C1e3t0YSQbnwTNlwm/MySpA+xfV24sYukFW4mio0Y0jGyXA57DEXi85ZMjcxtFZrLsIR3cKJp/xJS8HsT5sPE44ryx051+0HP8e2os9XtFbbtyHZh346r0rnCPFZOAPmOGsLrrBYYFJ8+9ilRQ4i7kazLaP0806owdchdUBaiLsZQR2yz4sXk91N3Erq2K3SJt+zdX1QbEsFmowWwTblw9M28wmA1OWifz2mO7Ozpg54xQyEX3Bh5KyA31qUWz+2WSmIEOMrPVR+8oXdWFDRIPwjD3VntrmUBaIKW+vI3Wj2Ax4oFSfYQjAhvCmBOsAUNZXYCwzOfxEwxGoCI+twPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SylsoA4Fvi60Qx5Ep2DqkuT5kdRNPUEYSTOepUZHcAs=;
 b=lUiF2qVoNWBeSpPo4X9vBhxrWevCheLTtdBfaqG9XQrcFkTyibP9RS4tY/avkajiWbRE7fhc2gbi3gRPxXeI1gvNvjJUUxAImnCpJDFnl+kNCDfVyji4lFs+6l7xteteXsMHf68Axm2UJ2fvDp2QqPxy7d+EvPXMm3oYMNT2rV4=
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:28:14 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:28:14 +0000
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
To: Conor Dooley <conor@kernel.org>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: dma: xilinx: Add optional resets
 property for ZDMA
Thread-Topic: [PATCH 1/2] dt-bindings: dma: xilinx: Add optional resets
 property for ZDMA
Thread-Index: AQHc7DR3iNIqcbqW70Cn0v+WtZBYg7YekveAgABlNgCAD1lsQA==
Date: Thu, 4 Jun 2026 11:28:14 +0000
Message-ID:
 <DS4PR12MB999075E402F2396B652F00DED28E102@DS4PR12MB999075.namprd12.prod.outlook.com>
References: <20260525105042.2249542-2-nagendra.golla@amd.com>
 <20260525110025.E5A6A1F00A3A@smtp.kernel.org>
 <20260525-petition-yogurt-27f2999d4968@spud>
In-Reply-To: <20260525-petition-yogurt-27f2999d4968@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-04T11:26:36.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR12MB999075:EE_|SA1PR12MB6776:EE_
x-ms-office365-filtering-correlation-id: ae083765-21bf-4cd6-85a7-08dec22c5de8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|38070700021|3023799007|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 1iaxzotQKaUSKi34BFGbR33TeBCeAi+uoohKs/a0JarbZfNtHPtNVR5Lsxu7ub3YZgitkYHBFIJBHA62fmX3DM/m5NhwND0Em/1NlrOE3yzZN5l+/8dOvA7bvKZ6mkxHw61E4ZmJLbnSN2HZSuQtKuvPGUtQ/4J8wz/EIG7ZCt0rwGiIGrACUwVqswsWB3LLkS7ad1/nFiSZb0ITlSDCsNQXqyHACHMJUV8bbrH/V+9kgar2CabDAjBN+mB6tiMV/PAxak6ftWJmI4wfV3GbKa7EnlNcyTPFgNaITMCFsEh6Zu5KNEPIs13/aRxaCwj6WIlUxoAqi1C8FMEESi1AhQbJFHs4wRVdpm2Z6AccU1pkg0o5eIppOAZzV1/OSrcYa/5Uk80OmWsgNFvUZIRw32sCy2p/owj0VHciUU5GEQAhDkrjFTOpkmOcEwvPww4yikqBIr685xmJWHGkxxl8EVM0l0+bOQei+jmpt4G6Pote1oykrYdZGL0ml+AA8y3iFP73qtu9xSOHOTjDhPJUwptahr4lOWYk2rnho9k77Khbfhqt54yQJUfXcfrdhJkpjKe3He52Ug6BumgC/HR6TBjWhUy80aYShSX+Zq/jOVmuObYCp3U6mAg0BuysAcXCQPXy05B8d4pJND/OMIzLByu2GFdtMJUCHb1EAS6jeeiNPpxfA5AIOA3y+wFxDHEm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(3023799007)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DgfhPQQabkz140xniv77RG8iya15/4oiNjJTLPI61zdBRHPniL4QpRtKds0W?=
 =?us-ascii?Q?pfCnYAX9sQh6r/Kf6EgPSnWP2TgjO2XMHxh07zOxaUhnYbbzEYrTBcwr8R4K?=
 =?us-ascii?Q?BWp/jHcgxNECWdV4VvpC1G+4f5ID3y1PA60CwI3jjiaZngZhKrj2IMZd+ZGB?=
 =?us-ascii?Q?ykJlbf2SuwMofqWnGiofNGyFfKO5v3S+vKJyhA4jrbNRh3bFHe1yufusHNYk?=
 =?us-ascii?Q?jIGT4ye3z7gfjt8WkyqKIYwBA1Q0LGd7N4KmN4ej4Xfa1n6RmRvvygXXjmRn?=
 =?us-ascii?Q?ja5RwKll+tppe02pkjSx2P4HG22N9TQJzOfyYVFmLAiJmyszMAbYPs/jWN2s?=
 =?us-ascii?Q?zVhG9b53oskiCbiV10za4LR3qbWxSbcGs75ZT2WVgmbKXknH/7OcCh7O8QOl?=
 =?us-ascii?Q?cXquOZ7/F3pqfz+U+wcW1EXxmToaEWctgHYN2vKMHEd508G0GrXYv2cxuHM6?=
 =?us-ascii?Q?8Xa9uMGjTPuzOzY3+RnTg1B5/qmq9Ls9845YIlFFPKf7sHPkfrEhbebuHwGm?=
 =?us-ascii?Q?ZhFkafMwS8a5KQYAeFtetOSfEXibhW2rHf5J0NWjeKFCHuJOZlrtceHRppBd?=
 =?us-ascii?Q?PuKJHRa0bLdygcp6i5+HV7r/K98vj7PGu4UQxnIXxl4I/s/MyhBFxhGMnTJ5?=
 =?us-ascii?Q?n06vCmCukFb/7gs6YomBt4Qsk5hPP0IjW9Zlql3PKcG7hb5WlFk7jQjX3Ae0?=
 =?us-ascii?Q?tqKgcdrWcj91zWdX/mlCsdW8Y5xs6/wB057KJ1cPbiefpYSoqXqpyM1pHIlC?=
 =?us-ascii?Q?NZRwXXJ5g85XmCvQNXZmvnSH4qLPxBvlGQJjM+qclWKEDdZBUEKTCzsOVM1R?=
 =?us-ascii?Q?tXypwKz9tR9MmRRnPGqd4vDOCOsNugJl2HbzkeJHlpy3ScpYskbhNCySDJMa?=
 =?us-ascii?Q?x4MiP8z5zPxSxXlujRteceBvm4zqg14iwp4RgcrdXw7wFYZp2HFu1um5++Be?=
 =?us-ascii?Q?0BB7q6cQy47AO5kcmCvEiinNcbQDjIdFYksIUIOk3SC24Q4lpTZUY/X4Y0LW?=
 =?us-ascii?Q?JDlLKeodZHgdqRgvl6MZMzdNMqNyVORDd/9CcxZtZkJGncawotwTZM2kAiMm?=
 =?us-ascii?Q?zgL3IFyuEEx3eaN7GDvcJy1OpOf3TDoQYJc0yBuF3XE5eAksbYS3DhO65hGE?=
 =?us-ascii?Q?pODoauxslpTyzI5kFdXCnHMab5pgkp/BNV6AhVeLYIvZin3/qD/Etsp5yULp?=
 =?us-ascii?Q?fBVWvezfkHZ+xizX4Pq41eP9GdouRfGF+zDZO458kVD3OtJmjTSSqtetOBrz?=
 =?us-ascii?Q?1p1IesZfu6Cdf1HesOPQz28/hzQGTlN/QL5/F2cd7QbrYu+uUJyTm7hM/Wvy?=
 =?us-ascii?Q?JMmbQF49BhdS4YpM8g/Vda7fh4Ohm0Q8mQLK4h6lcO5uMQDiscTAngATVewJ?=
 =?us-ascii?Q?LEgw48YlVROosCKxP71rYo7/Iv89qoq3W6aiv6doAVw+GiTqe2aOEPhXSuTb?=
 =?us-ascii?Q?Mselzj0TwXFMe2H2BX6OzYESyZIrIrARlKYfxhgEqTedy2bM3boAeH4kltoa?=
 =?us-ascii?Q?GcoFbEYcZBMnVjXxSvUMBYbVWPoUTcvp7+4AUcgYhfCltlFjVYHk28zWtUnu?=
 =?us-ascii?Q?4LJ4EOmNUVJcSZv15UYmHkGhpFBZPdIgjaA3YDnG63z4Q8EF7tmepDoqymnE?=
 =?us-ascii?Q?xSK65srIbRAPkZJ2UW8PCEkdCZm7/f2dVXm7ICd+xP6WQ33gEmklFb5rfTc6?=
 =?us-ascii?Q?lIaO54UnBh8b6W7z3dtefUL3X97GejwKC+y6E6G5ddAFtca1?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae083765-21bf-4cd6-85a7-08dec22c5de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 11:28:14.3041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTrAEhI45yHQDAaS6smb+MNBJvyCREvWL5TTLkS9OtYSmGHFMiZK4z+pCjngWbK1eg13OpbKen1H2EoMf2GIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11162-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:sashiko-reviews@lists.linux.dev,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:robh@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:conor+dt@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Nagendra.Golla@amd.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Nagendra.Golla@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:from_mime,amd.com:email,DS4PR12MB999075.namprd12.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4A6063F701

AMD General

>-----Original Message-----
>From: Conor Dooley <conor@kernel.org>
>Sent: Monday, May 25, 2026 10:33 PM
>To: sashiko-reviews@lists.linux.dev
>Cc: Golla, Nagendra <Nagendra.Golla@amd.com>; devicetree@vger.kernel.org;
>dmaengine@vger.kernel.org; robh@kernel.org; vkoul@kernel.org;
>Frank.Li@kernel.org; conor+dt@kernel.org
>Subject: Re: [PATCH 1/2] dt-bindings: dma: xilinx: Add optional resets pro=
perty
>for ZDMA
>
>On Mon, May 25, 2026 at 11:00:25AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s)
>to consider:
>> - [Medium] The `resets` property is added globally without conditional
>constraints, allowing it to pass validation on older SoCs that do not supp=
ort it in
>hardware.
>> --
>>
>> commit 832c482914e7639cb1a410d061bf9d631b41ae68
>> Author: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>>
>> dt-bindings: dma: xilinx: Add optional resets property for ZDMA
>>
>> This commit adds an optional resets property for ZDMA on newer SoCs
>> like Versal Gen2 and Versal-Net. Older SoCs do not have a reset line pro=
vision.
>>
>> > diff --git
>> > a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.y
>> > aml
>> > b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.y
>> > aml index 2da86037ad79e..dff16763e11b9 100644
>> > ---
>> > a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.y
>> > aml
>> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1
>> > +++ .0.yaml
>> > @@ -56,6 +56,9 @@ properties:
>> >    iommus:
>> >      maxItems: 1
>> >
>> > +  resets:
>> > +    maxItems: 1
>> > +
>>
>> [Severity: Medium]
>> The commit message notes that older SoCs do not support this reset line.
>> Since the resets property is added to the top-level properties block,
>> will this allow device trees for older hardware to erroneously define
>> a reset line and silently pass validation?
>>
>> Should this be guarded by an allOf conditional block restricting the
>> resets property to the newer hardware compatible strings?
>
>Additionally, should it be required on the new platforms?

Hi,

Currently, the resets property is optional for both Versal Net and Versal G=
en 2. If future platforms add per-channel reset support, we
can add an allOf conditional at that point to make the resets property requ=
ired for those specific compatible strings.

Thanks,
Nagendra

>
>
>Either way,
>pw-bot: changes-requested
>
>
>>
>> >    power-domains:
>> >      maxItems: 1
>>
>> --
>> Sashiko AI review *
>> https://sashiko.dev/#/patchset/20260525105042.2249542-1-
>nagendra.golla
>> @amd.com?part=3D1


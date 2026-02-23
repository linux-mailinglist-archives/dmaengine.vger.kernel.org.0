Return-Path: <dmaengine+bounces-9008-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAVcD6+GnGm7IwQAu9opvQ
	(envelope-from <dmaengine+bounces-9008-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 17:56:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2317A335
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 17:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9711317DDCB
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E97830BF68;
	Mon, 23 Feb 2026 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="If9P2eOP"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC7325711;
	Mon, 23 Feb 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864817; cv=fail; b=sZXDuUpcLv39BpriRu9pzQLI0dEm7CP9/v659ZznEdwTxE/XNU64EGQXSS+2uW4cXLf0yPT9FDN1zYSjW2Yeg0J8VuiuRCMJlchBduBno1FD+yLbO4LbomPRNEQMZqh+93Xp9xrO7U9bvGh//t10vmOhHL3MD37gLbOt9YutDm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864817; c=relaxed/simple;
	bh=rKvpAIPm3ocVqgSxclgSuspQCQLsVHCvFH5yjqe+S9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C8AwNMP88G6CtZaVqE4nbOMHg3T9LhMllPR6RoBBdyrVIOOvAMf5CCd4gjXDvAc3B/cx8IppuAlECn5WTnnV5aAuoHF/F5kz9O4Bsu7hivrGl0MwfsVVouJYY7fgwxGZIxNFZA5Sgq75vpPrQ8lobXzomo3v0eIrHY7uSSbkLvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=If9P2eOP; arc=fail smtp.client-ip=52.101.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgbIAnITmozBn6R0CAsR4C16BdWyeUgyr/zwCt9ob2mHaH3FusUpYDRIOtxpMzHo2C35nqDsojDck8hJxyZKDsGpu5JcTFfBxVOaoI0SxJ6zrTq7FjsXIbWPfICPbs9WPJUEqtaoIwpzJmSlxe4lHqcDqoRV53u872nzSW5DH4NWG4WdGshEcf4RA67JLpVyg5NK1aJOxG5AMdwZeMuBEj4s40OFjC/oVld3NO+L47WucAFY0TNWSyfXa1aCmC+UPTMF/tHFGmdzSboGmzKj1uG99YKMntGWnPJoDO41+IlGrxFdw311US2EfvUN9Qv7/ZzeJelgxVbYPuiZ2wEurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWyAWTsleW5n2jwbJgUlqlyDZ3dlIV+EoYDH6J9IAn0=;
 b=d7rSK4RRcx49m/dqoGdjK0FwDfxAukOs4T6A1OuwgTSEmtcpGCYVfSwn0RLNJVgFnDs+bEahX0IcTxlpjjMOXpgkhY7SZv+giYCPsIk8FhLD/fQq9gOPUyTiWErEkytLAeLVNXeAIxvaY0lyEyH6RVyIyDvO96Tbc7UkuKaWy1VvOn6GHDeXkgfpH+qHfwzSqfCV+U0sL7mJ36GpPFCi1Cmln1Luy1eS/opSQ+31fLapeAhbIYiGEY9xhxG9P913K+MgYc83coLP7GzQfb/Pil/gqxk2cMRqnkwqtjSzNzqzJzC0pBefSiR7UoQ5Rhnat09/UV/fP4q72fMQJCodEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWyAWTsleW5n2jwbJgUlqlyDZ3dlIV+EoYDH6J9IAn0=;
 b=If9P2eOP9xaL1xIJyHNbBPo32Rn5gi7+hZWPU1wsoD2lIZbWSW4DMlzzeQ4goeNZXb2JpMnMV+51NoKftMYPTLFUXbjz+8o/qHt/EIqZKyeIwGlHzjKYFL2tJ3jW2zEa7O8lRKeP7uH5sEHwjgt9YMR6dNeRS8UuX7nlBb+Ir9c=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 16:40:07 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 16:40:07 +0000
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
 AQHcnzLWCO8+PlOBsUyeigW/SoG/H7WFuzkAgACmYXCAALfggIABEsjwgABxvwCAAOnmsIAAvjoAgAEKjvCAAHWzAIAEwNdw
Date: Mon, 23 Feb 2026 16:40:07 +0000
Message-ID:
 <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
 <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
In-Reply-To: <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-23T16:38:16.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|CH3PR12MB7739:EE_
x-ms-office365-filtering-correlation-id: 5822b84c-9787-4eee-a073-08de72fa3421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hbtXjJw5FXNjslFbst6Ei0WvftundU2eHGKuX47L12K/yQXAt9QfFV3shNUL?=
 =?us-ascii?Q?5CIuajoP1AHa0IwiEG2sEidgkcxiWqCWTCm03Ey6JQoDIIZhawBKdEHiSyOJ?=
 =?us-ascii?Q?wt9C4SiMYTgI6jxrdxXnYo1u2M/lxyUqABBQvJyx1xOaDTjLjJNZALKBhQLh?=
 =?us-ascii?Q?/m2qjRXBTC6cgBU6QzExunN/UGPwPiTZkdAWJJ8ARCLkPLhRgfFsz/vLICGo?=
 =?us-ascii?Q?B/LA7xWzPOmX3SgVeM3lpNA2qrwsVEckmsLUaYJNGORH2l2ZHH79zElnNR6z?=
 =?us-ascii?Q?XqO9qrJcBqSIx4xXwEKV6NDZF/2P/fMTD01yC0yhPAHh+3HUD6lS4czaOvzV?=
 =?us-ascii?Q?IxhFCHCZNkVOTOJY1+lvy+r8u1gWd5AsaJW3Lpb6Bf/qw7nU7CPQtbIX0N9i?=
 =?us-ascii?Q?r8825j38LSonCscX59UWoL324lAjRmqX+kJYgsqDxl1FmcFSS29r7wfEX+10?=
 =?us-ascii?Q?gW4+wl39VCjGcI0R91HG7BS5ZcKa1+e6Bfw6gKMJYrBhEyPUnXREm/kAFQ1z?=
 =?us-ascii?Q?5SDrXv6MN4cD6bp3HXZu737W1XkeJA9NMEN79rnI6ffLeEwmiJcXaMfYIJ4C?=
 =?us-ascii?Q?R8V30O/yTb4QIl1Dcoxq+9dTq5TWSWMamIQX88yfxb9poQXseMiL7F4vFdyY?=
 =?us-ascii?Q?dqIfrNJZz7tWHjoFc+4ZHYMUk83F1WZfggMzktuBbKAgkfGYrBb3qkfJzu1K?=
 =?us-ascii?Q?QUoAkoTdq5G3Rp9BsvQE7CaQoyy8GFv9gRSMxZyfuIFGaVv1De1P3ULFDw5c?=
 =?us-ascii?Q?K/7cP6BBXNr3bh+F/u6jN2LgxZn8ketLsAt8DwrfBoC1Tx3FiRNkxzkNWh24?=
 =?us-ascii?Q?NtMD6JsaoomoRuIPM+SgAWt/zxdloU9YPkN6YV7wLpFtJ+c9pRkBwewgXAuO?=
 =?us-ascii?Q?FWYZjfxJPJfIoFWlFBxvkfuvEHv3PJJqJD5YF0a89WELLjT4Y1UMld2aG34h?=
 =?us-ascii?Q?Cb8SU2ED8NJVHFXer08lA/KE/4L4NVjFRwl2tMwKIfXsofXk0n9vAuoAIA+i?=
 =?us-ascii?Q?u+6ZRw7tqQCtx90iLcYoZqymrEEHs+6dwasTOh6RJIaNduArr4spDaegUpem?=
 =?us-ascii?Q?/TGKAoVmtWTIaEzQtZtePfeLkCUP4pg86VVkNOrNnvnsk8INFhu2RfXKdVAC?=
 =?us-ascii?Q?FI9X54sUgAjH8SnaT3NYFSWn+q9jdz967jZifeu15KWZLfz5PNPsh/rsqv1s?=
 =?us-ascii?Q?Zzu2guRzsjLGP0YGPR1kV2BMH4vJwTXKiYYzHgu2Vm3qmnPWmHFIimPh9IAi?=
 =?us-ascii?Q?abbLAdvXpsx0DO+fDrF/rO9rB4XWzqSDpFpq+CdpQEOxAtYTFBW033y657lx?=
 =?us-ascii?Q?cQdY1CjrzG2k7SqrCSDEGvZW/aXQ77TNejw1RBOonhncmbVAeZvlKWsjNxQs?=
 =?us-ascii?Q?E1CcWfY1oZGSvLdpTmtCpl7P2jbNuPYWq2u1Q8L2n6kyvk6PfDOc8F0XZLne?=
 =?us-ascii?Q?vlsgw03xGvj56+eP4vCPtmXp0HhmGj/R3eoN6QC8lQhF6KGKFqJhUTOZ1beH?=
 =?us-ascii?Q?jKm4pD1Bs8cHknEcLaW8HtkUKmurRhJWzmuNHemwGDpNQtta6Qh0Pw7Y7GZj?=
 =?us-ascii?Q?LT6pG3JBGlgnG0GA124HZwd89T/SlDOsH7NatFJCwShM+U6KqJCsdDYY2CEz?=
 =?us-ascii?Q?SgErrANEbR65IFXgjqt09W8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FHsU9+Dy5FtkTEpjLuCttREIfQ7I6aw6ZIG286zIdKefbCw6K+8e6AQTRx1b?=
 =?us-ascii?Q?JvbFPAAnIh50dqxLyVkGvR0KlO5Mk2YpxPvjEEh/74pCJu+TBnYDtZAyWxzV?=
 =?us-ascii?Q?wpwyerUSHjz7UL6tOeGGR3WlgaTNZ5ber0iGAN9JpwwefsBjZ56J2rvqUNWT?=
 =?us-ascii?Q?1Qo08lzqa8CGTsUY5vqsjaN60aro2NQTBwz2evp2p/U7S5IgZSsNvSbuO/2w?=
 =?us-ascii?Q?SURJg6xot+j6QWX7JCuE1tKnPTD2B7ae8Fmmly5yw6L7Xt5XL67CvcEOSVSQ?=
 =?us-ascii?Q?oupp6HHngjWbzrfO2uWOD4fju3a8oy39L8jZN3ZVxzX1go7T23J5qNplg/+L?=
 =?us-ascii?Q?AxExeMAxRVpc90IqnhpcTkBWn9I0RZWNe99RmL1kduTXtvBY9SW9nAFhXChS?=
 =?us-ascii?Q?5tGXPDs0oYo9ah7S2jyGWWNsn42HUj6n1zc/Bk4lq59faIhMzs+aQOlg9Vnw?=
 =?us-ascii?Q?ToCV5brP6HzpyImuzbGVTViDsFuH+is6ujvhz0A3BCFQaSHq6RfJaLwRNOxy?=
 =?us-ascii?Q?yCH8HzAYpo/ZYptYzmomkXOlzbLTrxqpd52SPN5S093b+lkZZnOc5ZQ/7Q6K?=
 =?us-ascii?Q?dBHstwXoclwJHR2/EQPUT1WJ5gkyqgRW937n0/WP72e6njXBfz5k5QizNzgu?=
 =?us-ascii?Q?8wuy94jAbHO9ybZKdYOBKrdF+sabMKgXGiDDbK/eKDGrJ7dE/kbPX0LwGC+f?=
 =?us-ascii?Q?VtX5ARfYDUBsaIPKtx4mfHSRCkcHZuZY0uHTYCvAEji0UW+Z9G1oamRIVqD3?=
 =?us-ascii?Q?jYBxd2tx4IQLqn0ng+ms/FVM9LCgpZ1hwFUpImMWieGHnxUz0A2x5DBNH5Do?=
 =?us-ascii?Q?zY/4Nxqw3+kC6xuFhDkui0IA8Uyf6JRTgYRvyn54jvoUXrGkTSp2/TC90Dav?=
 =?us-ascii?Q?Zc8vokWPw+8H7bS8O/BpN1GTl9GR4ASxryJqK03j8pyrj8beLGOHfQ2M6+1Q?=
 =?us-ascii?Q?1U1LvocPK5jrDlyjLZ7ImFPb+Mc1jIH1xji06DwECgyVa9FRcHCS7OAW+1Rz?=
 =?us-ascii?Q?1GzUsIvpJS3ufx/AyC383v4eIFU1FeB6sOly2PjPUfExC3RycdbwU0LlESOv?=
 =?us-ascii?Q?uSKO+PbcXnuKm2X8CQdyiJeOZnddtswOVj7Qn6BmocbRVy4AwNlfow6fOjhy?=
 =?us-ascii?Q?HjBcazMMHdo+cIy2qz3+0cUAfNLrPo0skJZDpou6SZCUMN7vRLs4P5DPpkBH?=
 =?us-ascii?Q?dIDbvUBHiDWhpSVRhFpsw+B2ns/cEhgPXJu6vrjnM6U+s+cBZ/9hMEZJF+HJ?=
 =?us-ascii?Q?U0rS949f64H6QMc8zd2iRG3JlzU4rPzUMsSNfgdhUrZvxTPUJ30Mg9mJ0MPa?=
 =?us-ascii?Q?VJt0RcxuShRCo0aV2EapD8sZ2Zk3ufPweZj70vD2m4ActX1TR03xnvDPLaxl?=
 =?us-ascii?Q?GGJZb+EyRn/QhN8iNBy5wV63pMEFDChHsBc27F6gBcIr2bqX7CHDKWlukihW?=
 =?us-ascii?Q?Ce+2TyngN7D48Rnx+X2wgo+38P5bvEiIzdXIkN9LlAR5/ibjyu8jcnGOU1IV?=
 =?us-ascii?Q?MoAVj/+MET49oZdbNcT+MXBQg+m1k4R+ylbSdH2TzB/U8fTHWzI7MRZVUu7P?=
 =?us-ascii?Q?/4wUSQGyeT5ZXPp/EVen2E9j5N5g2hnzSzoEL0A/C8YvtLJ6m8F7ufLRK0vd?=
 =?us-ascii?Q?K5Lw2PCVJ+BQJsnQogY5LDf8pfh7suP+enD6OTbyxhUIq6X7labMAfjSFmLA?=
 =?us-ascii?Q?IVIjh6oT4mU/fgJ4K7ldiGQTc+IAfoj0mTJingYrUw5CxA/s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5822b84c-9787-4eee-a073-08de72fa3421
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 16:40:07.4981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spWDMwjVrdGKcfUVJeJBAoEbaRDNLweDoRUdlcD45DveyuHZlaPY3bCDqy9myVaasNY/NwbbMfokK/5xdyWaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9008-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 70F2317A335
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Friday, February 20, 2026 9:33 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Feb 20, 2026 at 11:47:59AM +0000, Verma, Devendra wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Frank
> > Please check my response inline
> >
> > Regards,
> > Devendra
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Thursday, February 19, 2026 10:38 PM
> > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > > mode
> >
> > ---[ Snipped some text to reduce mail size ]---
> >
> > > > > > > > > On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K
> > > > > > > > > Verma
> > > wrote:
> > > > > > > > > > AMD MDB IP supports Linked List (LL) mode as well as
> > > > > > > > > > non-LL
> > > mode.
> > > > > > > > > > The current code does not have the mechanisms to
> > > > > > > > > > enable the DMA transactions using the non-LL mode. The
> > > > > > > > > > following two cases are added with this patch:
> > > > > > > > > > - For the AMD (Xilinx) only, when a valid physical base
> address of
> > > > > > > > > >   the device side DDR is not configured, then the IP ca=
n still be
> > > > > > > > > >   used in non-LL mode. For all the channels DMA transac=
tions
> will
> > > > > > > > > >   be using the non-LL mode only. This, the default non-=
LL
> mode,
> > > > > > > > > >   is not applicable for Synopsys IP with the current co=
de
> addition.
> > > > > > > > > >
> > > > > > > > > > - If the default mode is LL-mode, for both AMD
> > > > > > > > > > (Xilinx) and
> > > Synosys,
> > > > > > > > > >   and if user wants to use non-LL mode then user can do=
 so
> via
> > > > > > > > > >   configuring the peripheral_config param of
> dma_slave_config.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Devendra K Verma
> > > > > > > > > > <devendra.verma@amd.com>
> > > > > > > > > > ---
> > > > > > > > > > Changes in v10
> > > > > > > > > >   Added the peripheral_config check only for HDMA IP in
> > > > > > > > > >   dw_edma_device_config().
> > > > > > > > > >   Replaced the loop with single entry retrieval for non=
-LL
> > > > > > > > > >   mode.
> > > > > > > > > >   Addressed review comments and handled the burst
> allocation
> > > > > > > > > >   by defining 'bursts_max' as per suggestions.
> > > > > > > > > >
> > > > > > > > > > Changes in v9
> > > > > > > > > >   Fixed compilation errors related to macro name mismat=
ch.
> > > > > > > > > >
> > > > > > > > > > Changes in v8
> > > > > > > > > >   Cosmetic change related to comment and code.
> > > > > > > > > >
> > > > > > > > > > Changes in v7
> > > > > > > > > >   No change
> > > > > > > > > >
> > > > > > > > > > Changes in v6
> > > > > > > > > >   Gave definition to bits used for channel configuratio=
n.
> > > > > > > > > >   Removed the comment related to doorbell.
> > > > > > > > > >
> > > > > > > > > > Changes in v5
> > > > > > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > > > > > >   In the dw_edma_device_config() WARN_ON replaced with
> > > > > dev_err().
> > > > > > > > > >   Comments follow the 80-column guideline.
> > > > > > > > > >
> > > > > > > > > > Changes in v4
> > > > > > > > > >   No change
> > > > > > > > > >
> > > > > > > > > > Changes in v3
> > > > > > > > > >   No change
> > > > > > > > > >
> > > > > > > > > > Changes in v2
> > > > > > > > > >   Reverted the function return type to u64 for
> > > > > > > > > >   dw_edma_get_phys_addr().
> > > > > > > > > >
> > > > > > > > > > Changes in v1
> > > > > > > > > >   Changed the function return type for
> > > dw_edma_get_phys_addr().
> > > > > > > > > >   Corrected the typo raised in review.
> > > > > > > > > > ---
> > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 35
> ++++++++++++++-
> > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44
> ++++++++++++----
> > > --
> > > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65
> > > > > > > > > > ++++++++++++++++++++++++++-  drivers/dma/dw-edma/dw-
> > > hdma-
> > > > > v0-
> > > > > > > > > regs.h |  1 +
> > > > > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > > > > >  6 files changed, 132 insertions(+), 15 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > index b43255f914f3..ef3d79a9f88d 100644
> > > > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > @@ -223,6 +223,31 @@ static int
> > > > > > > > > > dw_edma_device_config(struct
> > > > > > > > > dma_chan *dchan,
> > > > > > > > > >                                struct dma_slave_config =
*config)  {
> > > > > > > > > >       struct dw_edma_chan *chan =3D
> > > > > > > > > > dchan2dw_edma_chan(dchan);
> > > > > > > > > > +     int non_ll =3D 0;
> > > > > > > > > > +
> > > > > > > > > > +     chan->non_ll =3D false;
> > > > > > > > > > +     if (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE=
) {
> > > > > > > > >
> > > > > > > > > Need handle EMDA case. if mf is EDMA, need return error
> > > > > > > > > when
> > > > > > > > > config->peripheral_config is not NULL. Or remove above
> > > > > > > > > config->check to make
> > > > > > > > > code work for both EDMA or HDMA.
> > > > > > > > >
> > > > > > > >
> > > > > > > > For the case of EDMA, the behavior is unchanged.
> > > > > > > > Even if the config->peripheral_config param is set then it
> > > > > > > > would be simply
> > > > > > > ignored.
> > > > > > > > This is retention of the previous behavior. This is done
> > > > > > > > because device_slave_config has other params which affect
> > > > > > > > the behavior of the DMA transactions, we do not check all
> > > > > > > > those params and return any error. The error is returned
> > > > > > > > only in the cases where particular parameter from
> > > > > > > > dma_slave_config is used and if the parameter is not as
> > > > > > > > expected or in the expected form. The parameter used from
> > > > > > > > dma_slave_config for the particular IP type need to be
> > > > > > > > known first then it
> > > > > > > can be checked for its correctness. This is behavior for the
> > > > > > > peripheral_config which is used for HDMA and thus error check=
ed.
> > > > > > >
> > > > > > > It actaully hidden error. Your patch provide an option,
> > > > > > > which need't ll memory to do DMA transfer. DMA consumer
> > > > > > > actaully don't know which backend used, which is private
> > > > > > > information by DMA
> > > engine providor.
> > > > > > >
> > > > > > > dw-edma-pcie.c is only one of all edma users, which know DMA
> > > > > > > engine's information because it creates this interface.
> > > > > > >
> > > > > > > PCIE-EP framework also create dmaegine, PCIE-EP function
> > > > > > > driver use DMA standard interface to get dma-chan.
> > > > > > >
> > > > > > > if (config->peripheral_config) { /* only your specific dma
> > > > > > > consumer set it now */
> > > > > > >         /* optional config information */
> > > > > > >         if (chan->dw->chip->mf !=3D EDMA_MF_HDMA_NATIVE) {
> > > > > > >                 dev_err("edma have not implmentent no-lll mod=
e\n")
> > > > > > >                 return -EINVAL
> > > > > > >         }
> > > > > > >
> > > > > > >         ...
> > > > > > > }
> > > > > > >
> > > > > > > Add EDMA support no-ll mode is quite easily in future.
> > > > > > >
> > > > > >
> > > > > > This looks reasonable provided that HDMA got the support for
> > > > > > this
> > > param.
> > > > > > An error check can be added in the next revision.
> > > > > > The addition may be slightly different as following:
> > > > > > If (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) { ...
> > > > > > } else if (config->peripheral_config) {
> > > > > >  /* error handling */
> > > > > > }
> > > > > >
> > > > > > Using the above, if support needs to be added to EDMA then a
> > > > > > check for
> > > > > correct 'mf'
> > > > > > in the if() shall be sufficient.
> > > > > >
> > > > > > > >
> > > > > > > > > > +             if (config->peripheral_config &&
> > > > > > > > > > +                 config->peripheral_size !=3D sizeof(i=
nt)) {
> > > > > > > > > > +                     dev_err(dchan->device->dev,
> > > > > > > > > > +                             "config param peripheral =
size mismatch\n");
> > > > > > > > > > +                     return -EINVAL;
> > > > > > > > > > +             }
> > > > > > > > > > +
> > > > > > > > > > +             /*
> > > > > > > > > > +              * When there is no valid LLP base
> > > > > > > > > > + address available then
> > > > > the
> > > > > > > > > > +              * default DMA ops will use the non-LL mo=
de.
> > > > > > > > > > +              *
> > > > > > > > > > +              * Cases where LL mode is enabled and
> > > > > > > > > > + client wants to use
> > > > > the
> > > > > > > > > > +              * non-LL mode then also client can do
> > > > > > > > > > + so via providing
> > > the
> > > > > > > > > > +              * peripheral_config param.
> > > > > > > > > > +              */
> > > > > > > > > > +             if (config->peripheral_config)
> > > > > > > > > > +                     non_ll =3D *(int
> > > > > > > > > > + *)config->peripheral_config;
> > > > > > > > > > +
> > > > > > > > > > +             if (chan->dw->chip->non_ll ||
> > > > > > > > > > + (!chan->dw->chip->non_ll && non_ll))
> > > > > > > > >
> > > > > > > > > if chan->dw->chip->non_ll is true, It should return
> > > > > > > > > error if you set non_ll false because no LLP base availab=
le.
> > > > > > > > >
> > > > > > > >
> > > > > > > > In case the 'chan->dw->chip->non_ll' is true, then the
> > > > > > > >default mode  becomes non-LL for HDMA ONLY. There is no
> > > > > > > >option to the user to  configure the LL mode by giving
> > > > > > > >'non_ll =3D false' as part of the
> > > > > > > >config- peripheral_config.
> > > > > > >
> > > > > > > This is API's callback, you can't assume caller do all correc=
t things.
> > > > > > >
> > > > > > > > The configuration of default non-LL mode depends on how
> > > > > > > > the IP is programmed by the user. The user is aware of the =
IP
> configuration.
> > > > > > >
> > > > > > > It is not true. DMA consumer don't know such detail
> > > > > > > information, which only know which dma engineer providor.
> > > > > > >
> > > > > >
> > > > > > For the DMA consumer the only option is LL mode as default mode=
.
> > > > > > In order to use the non-LL mode it need to provide the
> > > > > > parameter in the form
> > > > > of peripheral_config.
> > > > > > Given the above statement, the consumer even if gives the
> > > > > > 'non_ll =3D false', it is not going to change any behavior.
> > > > > > Even if the user is not giving the option the assumption is
> > > > > > that controller is in LL mode, unless the DMA engine provider
> > > > > > provides the information regarding non-LL mode as default mode
> > > > > > to the DMA consumer
> > > > > explicitly.
> > > > > > In the case where chan->dw->chip->non_ll =3D true, following
> > > > > > case may
> > > > > happen:
> > > > > > - DMA consumer provides no peripheral_config param or simply
> > > > > >config- peripheral_config =3D NULL,
> > > > > >    in this case non_ll =3D false which is the current flow.
> > > > > > - DMA consumer provides a valid peripheral_config (!=3D NULL)
> > > > > >param but the
> > > > > value is '0', in this case
> > > > > >   It is explicit but it would have the same effect as above cas=
e.
> > > > > >
> > > > > > DMA consumer is supposed to provide the only option non_ll as
> > > > > > it was not available and LL mode is set as default for the DMA
> operations.
> > > > > > When 'chan->dw->chip->non_ll =3D true' then this was added to
> > > > > > make the chip usable when the LLP base addresses are not
> configured.
> > > > > > Without this, user cannot use any of the modes be it LL or
> > > > > > non-LL if the LLP base
> > > > > address is not configured.
> > > > >
> > > > > little bit confuse, Maybe the same as you. I expected behavor
> > > > >
> > > > > config->peripheral_config =3D NULL        choose hardware default=
 one
> > > > >                                         -           LL mode if ha=
rdware support
> > > > >                                         -      none-LL mode if no=
t ll list region
> > > > >
> > > > > config->peripheral_config !=3D NULL
> > > > > EDMA: return false
> > > > > HDMA:
> > > > >                 0                       force to none_ll mode. (a=
lways success)
> > > > >                 1                       force back to ll mode  (r=
eturn false if no ll list
> region
> > > in
> > > > > chip)
> > > > >
> > > > > DMA consumer decide if fall back to none_ll to continue.
> > > > >
> > > >
> > > > Thank you for the elaboration!
> > > > I have few questions, why shall a DMA consumer decide to enable LL
> > > > mode when the default mode supported is LL mode only?
> > >
> > > LL mode only is software driver implement. Hardware support both LL
> > > mode and no-LL mode. Previous driver implement only support LL mode.
> > > You try to add non-LL mode. Choose straightforward forward method.
> > >
> > > One indicate hardware capacity,  one actually used. Like PCI INTX and=
 MSI.
> > > If support MSI, most case use MSI. But still support switch to use IN=
TX.
> > >
> > > My key point avoid hidden beavior. Every branch is clean and
> straightforward.
> > >
> > > >
> > > > If DMA consumer is trying to enable the LL mode, then one must be
> > > > knowing the configuration of the controller that controller is
> > > > working in non-LL mode, as LLP base address is not configured,then
> > > > why to try and
> > > enable the LL mode?
> > >
> > > The DMA consumer don't know these informaiton.
> > >
> > > >
> > > > The user need to know, at least, one detail from the above two case=
s.
> > > >
> > > > The use for non-LL mode is useful in the following scenario:
> > > > - When user want to utilize the LL regions also for DMA data transf=
ers.
> > > > - For single and big chunks non-LL mode is useful in both
> > > > use-cases when
> > > non-LL mode is default or
> > > >   user enables it via peripheral_config params.
> > > > - This addition, inadvertently, makes the DMA controller usable,
> > > > for AMD
> > > (Xilinx) only, when the LLP
> > > >   base addresses are not configured; it can be used in non-LL mode.
> > >
> > > LL regions may not visiable,  User can use non-ll to config
> > > LL-region and switch back to use LL-region to continue transfer.
> > > User may use non-ll as indirectly reg access.
> > >
> > > > For Synopsys, DMA controller
> > > >   cannot be used in any mode if LLP base address is not configured.
> > >
> > > Does spec said it? It doesn't make sense. it should be controlled by
> > > LLE of DMA_CH_CONTROL1_OFF_RDCH_0.
> > >
> > > >
> > > > Based on the above points, if user is trying to enable LL mode
> > > > when default mode is LL mode, it looks Intentionally making the
> > > > choice when user
> > > is aware of the mode DMA controller operating in.
> > > > Please let me know if this clarifies the doubt.
> > >
> > > No API to get mode, only use set and test to know it.
> > >
> > > Actually Needn't consider so complex. like functions API(x)
> > >
> > > We just consider input x,
> > >
> > >         validate x's input ragion,
> > >
> > >         if x is out of region, just return error.
> > >
> >
> > Thanks! Will update in the next version.
> >
> > > >
> > > > > >
> > > > > > > > The check for non-LL option provided by the user is useful
> > > > > > > > when LL-mode is default. That is why the value of non_ll
> > > > > > > > =3D=3D false is not even evaluated.
> > > > > > > >
> > > > > > > > > > +                     chan->non_ll =3D true;
> > > > > > > > > > +     }
> > > > > > > > > >
> > > > > > > ...
> > > > > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > > > > b/include/linux/dma/edma.h index
> > > > > > > > > > 3080747689f6..78ce31b049ae
> > > > > > > > > > 100644
> > > > > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > > > > >       enum dw_edma_map_format mf;
> > > > > > > > > >
> > > > > > > > > >       struct dw_edma          *dw;
> > > > > > > > > > +     bool                    non_ll;
> > > > > > > > >
> > > > > > > > > Can you check ll_region directly? it should be equal to
> > > > > > > > > (ll_region->sz =3D=3D 0)
> > > > > > > ?
> > > > > > >
> > > > > > > Do you miss this questin?
> > > > > > >
> > > > > > > Frank
> > > > > > >
> > > > > >
> > > > > > Yes, looks like I missed this question. Could you explain a
> > > > > > little bit more? I
> > > > > am unable to understand the context.
> > > > >
> > > > > you set chip->non_ll =3D non_ll in dw_edma_pcie_probe()
> > > > >
> > > > > and only set ll_region->sz =3D ll_block->sz when !chip->non_ll.
> > > > >
> > > > > Thats means ll_region->sz is 0 when chip->non_ll is true.
> > > > >
> > > > > So non_ll have not bring new infomation into dw_edma_chip.
> > > > >
> > > > > check !ll_region->sz, which should be equal to this non_ll.
> > > > >
> > > > > dw_edma_chip is the exchange information between controller and
> > > > > dma core driver. Needn't cache it here because you already save
> > > > > a copy in dma-
> > > chan.
> > > > >
> > > > > Frank
> > > >
> > > > I understand the concern here but it does not look good to
> > > > piggyback the non_ll related information on the existing variable.
> > > > The use of bool readily points out the information related to what
> > > > mode is being intended but using the ll_region->sz is an inference
> > > > the user
> > > has to make.
> > > >
> > > > Having ll_region->sz =3D=3D 0 does not really tell it is non_ll mod=
e
> > > > or not, it can also mean that the size of LL region is zero while
> > > > in LL mode
> > > which could be an error.
> > > > This does not translate to support for non-LL mode. This brings
> > > > the
> > > ambiguity.
> > > > The introduction of the non_ll provides clarity and easy
> > > > comparison with the similar choice (non_ll) provided by the DMA
> > > > consumer in the
> > > dmaengine_slave_config().
> > > > I request we shall retain the clarity here.
> > >
> > > You can use helper(dw_chip_is_support_ll()) macro to check chip's
> > > capatiblity.
> > >
> >
> > I do not understand what you mean with the above statement.
> > But if it about writing a new function to check the LL mode support
> > then I think the current variable is good enough which provides good
> > readability and do not create any ambiguity compared to the ll region s=
ize
> comparison.
>
> It is not big deal,  use 'bool cap_non_ll: 1' in dw_edma_chip. So we add =
more
> cap flags in future.
>
> Frank
>

Hi Frank, could you elaborate what you mean by adding the cap flag? How it =
is going
To help identify the overall chip state?
I do not understand what is being implied here.

- Regards,
Devendra

> >
> > > Frank
> > > >
> > > > > >
> > > > > > > > >
> > > > > > > > > Frank
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > --
> > > > > > > > > > 2.43.0
> > > > > > > > > >


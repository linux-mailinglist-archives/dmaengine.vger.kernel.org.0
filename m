Return-Path: <dmaengine+bounces-9292-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK7tFPC/qmlXWQEAu9opvQ
	(envelope-from <dmaengine+bounces-9292-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 12:52:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A217721FE7D
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 12:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7052302BDEF
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE42D8768;
	Fri,  6 Mar 2026 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BptM9lLR"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92806364054;
	Fri,  6 Mar 2026 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797844; cv=fail; b=EX0HtZFUUouJLfQJ7npXL+BNbt9zBQjT+oBGijjLAHxb8K9KdzxJPHhOnY6J8ByqPKaEIPYQUf/VgmEkXmZi5JUi1zftVYLbGXzD10rvLWZiyDmoeWMYMTl9YES6nohhKC6UUdY5sh3TWULXQkAXsEFs1sSMdwYz9SrWLMUWafA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797844; c=relaxed/simple;
	bh=nGsIQG3DY0/PKVO8bc/phoa3Q7BqXrTsBBS3T9/0TsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tVe8FisvPkiR/32T83qSg9Sr9Rd2zBEBe5/POVf5RFMPETh3FQmzu20gBeLysQVcZctW43zi8prlQWCLcoP1ygRq5j6z/pVZKLoBS76GWpoIqN/0jC4e3IS1VvJ5cKjjjFdgOa7sYQrEFlHO0/Fr6tp4iJWW3a+rSUcyDBVhu+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BptM9lLR; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwXVdQ4k8ZdUDN44xjlkoK/NSJJuZzFABJpzxhyS+JogB6hvUeemFL337nGKB4SU18KrH4JG3svxl7aKv4u54kyo58bwK6FisSu1Lws8AA10NeQmsksXP76Os+D1hddcDbGJKUmD4mCLxIZFSgK2kK+dbEZDcRNzbBNHfpOLWnYLI2OSwWvzBiODqw/c3IiBecHWvVvZkE6L7dw1whACRYpNfb0RKh8Pzp16MCYq2eB7X0HLyrxvuwj/S8FJ6S1OZZQDfG3W6OJGpy7LdmlkvxF2FSVBIU8m5Q2+OOjSbpGdju7z7fDCE79zuy6HNi5hXljcO4pMCLH7yB/RLOKMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=empbgVo91/W3M0cw29MC2kIY/8WVWqFzOR0aki5y3tI=;
 b=J9H+jdMvlB6H4vuRgIviQDuRhaKBGqVXFHxmvy9BffOk2c9Zu5OMH0K08LwurOwUqACGEpi5u91VXFlXF3K0gOslrXJJGzTGwGx5p5av8JQ5UJIEzLEaB8vlEk6KWlo8HQAeoPeGn4bvIqzR5GFX9/NK2gIL1BqgY80nLF4q4QSLmK8eSWw7lI9lVEH2Ciq6SsTxFKUdbePT1LsGIwdQm/rIRDUQmv3advo9Nf3YP1NYCB5t8USR+AcN0SQR1GE0Rj8hwC9wig0LpvBH7v2busrIMPyHj6DwiDf8BvXsLpjY17EdShblCyI5iKROcShvD1LPG2cDrz4Jef4/sLRT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=empbgVo91/W3M0cw29MC2kIY/8WVWqFzOR0aki5y3tI=;
 b=BptM9lLRuz3Lh5zI+vn/O0bkDuE9L3a2kOXOQWxmRpXEu763afFrqY3Zk3RV8U4WiFEx2qjagvd+mbhlowTKlECTZa3x7goYEBCRPSwkj+WjCiDeTK/upcLH1X6HAdOaUnD1oeRcgOjv3BKxDUjK4XMA/HckMgNqX/fdGAaEKKk=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 11:50:39 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 11:50:39 +0000
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
 AQHcnzLWCO8+PlOBsUyeigW/SoG/H7WFuzkAgACmYXCAALfggIABEsjwgABxvwCAAOnmsIAAvjoAgAEKjvCAAHWzAIAEwNdwgAHz+ACAAMV0oIALcI6AgAE65FCAAEjQAIABSDxw
Date: Fri, 6 Mar 2026 11:50:39 +0000
Message-ID:
 <SA1PR12MB8120C4D396C9146409C8C171957AA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZ4l4IHqObEP8DfP@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203E3A32F0670DB15D63059575A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aahkKZ9EBwWfwy95@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CE2DB5EB97512E51F76B957DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aampZJo-9UgzpIV1@lizhi-Precision-Tower-5810>
In-Reply-To: <aampZJo-9UgzpIV1@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-06T11:38:35.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|SJ2PR12MB8941:EE_
x-ms-office365-filtering-correlation-id: db330586-406e-4db0-abcb-08de7b7696ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 2Q1BBKERoH8FLZufGh0vl692PMZMmM0JBmPqqu4bScCRJfoBre/KG5nBTrBekUG88nTuayLcO5FNwC6mmsKODPPpnNDrlGnrVY36euhWqjreqsH4Gf+wP+rr8pk9hqF7HYRvr3No4pFcCL/IqB9p8OGlXQUsJ/Knxldm5HpKT26lKHQJFQIf5xmMPhlalRkRbIrvN+koGvJFW28W0DnF5yMzNqLEaspHWxcvQRjDk8qnYZBRwftgwDu0UM20MCz2GU5jzXvTuFEInqCa4q6HNNKt6c81j2bZOzKlMxxDaMyryeoicB7fwSxZFs53BX1HSOhVd3uWR922BSigTOQ58SQ6IKqVDKtA3hV+49fAdU284yRs3cibPsLHEakyPfSWkL+DEKtcTFSh4hwZXTxvdUykEZbLyrxszoL9/doXVGV/zQSEptO3p2phUBD6inmKfiMGt/mVAhzLaAlBeUnzOPMJ8Zc49XDRv2NZtV4USlau9oVSqq2nZjGopQ5RrWS71ConELKUPg4S0JhOHQj/5zUkZQE20Q78jsLEuej/8d339I5pwVe57YfgK4C3UaGutNlrBoHrRKjjCpeFPPXayBS6KzcXdbI0PlGB5Ov/Ur1rsCQmUXFRA6acZxwitBRcBpxe3pZn62JZ90yMBky3yN3kX9P+ynwvfED5sMM1WWOvdlGoBykRuDmbdkXfX/xq38pkLGAY5vJogaVP6uznAuQ7qDR+09DQAKCZQC5XYMfxf281Q2rLVK+qHA3rZQ7Mu5DpUTy3hvSNqPx28b49fcPSfhkewYvi3pu7FdqCb0o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XWvc32k4cDzwTKBNCN1s/2V9nm9ihoBu548dmwZBykkLqUG3JW/5ZBZufHc0?=
 =?us-ascii?Q?Eh+GodaBOuTRXqFFkROHDWj298EYodafRyvomefgG/tVb+PCGc38mmvWKJzN?=
 =?us-ascii?Q?sYNDcHwwPtj4No0epZbPVi2nBVCRADdDfeVF/qmL654nuO+mcOvtAHstD+RK?=
 =?us-ascii?Q?vJ62EfXJ8YPpPdsqJTxivhoz9YwskHwsJK01hzwKpzZEUT24Pq/MKq93AZIf?=
 =?us-ascii?Q?H5gYnH4tg2V7O6s+ySr4RFkkulVNNHWH/N7WJrFyAreAzjdrexm4y3JZpg2G?=
 =?us-ascii?Q?pfpW1iewAxrczrvgU04P9t9/9wp2ciwF/4mq/edXOJxRQFze3k/0D92b4baD?=
 =?us-ascii?Q?RboOcao/1f1K2tMDht+5Rwg58IRpisTSxI3bIWhJcHjxp1PGHCIFFw+sKQ+H?=
 =?us-ascii?Q?Qf7qYt3+qu8FDlGnSEieVWML5G6rtd5RQ/zHjfY/rnU5yfCMKUYqS/uJ8nlf?=
 =?us-ascii?Q?6lFaNl26AtfwDBPqfuqu5IFxfB0lEJa8nTodZ1sIzr60FNbCKKGwC2dQaRbG?=
 =?us-ascii?Q?JE/qkhQna6UI6bzxHZTVDEL5w4Dsk28nFQzek8OMvAecIxZsCCFF2TYBRh2v?=
 =?us-ascii?Q?Epbs1ahPGrj7hhNlNb/5eB82aaDEUtfCMuqnfyWV8hPI9DF9UgjWPBM7af4a?=
 =?us-ascii?Q?F5kAVo825ghCRY818uuSyaQSmzE6qOlNUXxFhTG9ymtlpTCm2yoZNHidr6TO?=
 =?us-ascii?Q?S6GUOlD5JVanMHS47EdpI9A3XvKwT9UFFDxs63+zs+wnq21u72wPhs9SsZ1G?=
 =?us-ascii?Q?SZWrI1pXuMwpx+1VxVv7vrpJaXZCZb83xBz6LO6sFKs7Q6uEo69xms/bPEkl?=
 =?us-ascii?Q?JmjkVnhZWRAVKHdyKL4qxVdPAa92E1DC3Hw/k447bq/kM37QNtX8e/dQDRnY?=
 =?us-ascii?Q?b5WS/RlKF1+2VQ38jO5Ive8TBK0yMxF390fIcmqST/tyQGCvL6HcSV/vE5LX?=
 =?us-ascii?Q?lbjGf8xzR0rwrmFI+MCCOIdhpHBOaM+OOK7ggLf/WvWccGhP19WNHsrAOykB?=
 =?us-ascii?Q?nLCBR60FStigpTcYxWNEwi7roa04PtCxireVpb6w7J6bbvwoZrPc0FzGkVHN?=
 =?us-ascii?Q?W8eSSA3JfiYwIYwEx6g4aqJNlXT96CiQTddmPCxbGM3GzK4Yj61VOpb0t5SI?=
 =?us-ascii?Q?f3hOWX5LRL7Ko9tXZbrQ2LOzDdVEaGahmC0Q7/aI8lL9DsPrTv/rxKWqSkHl?=
 =?us-ascii?Q?iyNpEiwFn2Xq54lv5r5rs3SCGpBCv7o4CpcmyU5dLlX6xwFsXJCVqscNiyPF?=
 =?us-ascii?Q?35woZj3Crq1/SYREWDwZXucnQEwejWJqrRZ8HXXBLhhaSR4aegSUUHNdWxpp?=
 =?us-ascii?Q?kzzjwGt4lk3/Ha5Rpum0q7uksXAc/IldRKhMUfIfKWJfJ9QMh33sXCO0Kb3c?=
 =?us-ascii?Q?ZuCPLPhpihNX2UZa1JErkhFLr9ETdj6Yc3w7cnTfe/ii3U53+TsO+WJgCKyB?=
 =?us-ascii?Q?Fn3UssDpLR/p4DJclbTSN2fKx/N34FZrwILM/h/nm3vRXW4yQuRM3UceJLih?=
 =?us-ascii?Q?wv7oYguCK+Nug/r5BnVdhTWBz1daGqNWLuzn70I3yMgd8FfbgV2SrRaoHEvt?=
 =?us-ascii?Q?SiEBcMslnzyIn0P5JlMVItZtxzDthitOj2zj6Wy56D82AkVRTL2o5xxMty1B?=
 =?us-ascii?Q?HvUCy752jFc11pn0odvfIPdkPlkMnfgD7Y5xGvXlaTMxXDOxtnX5W+9TQyOL?=
 =?us-ascii?Q?pCCjI7QvuUBmYSyrpQpK+Z7m/2uCgn4ZAZ5Orht3dV789RWD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db330586-406e-4db0-abcb-08de7b7696ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 11:50:39.7156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGij2or6k7yLL9rnUFjJZwH5TvrEBfblOURZe7WXbDOI2Ln7KIvv4PcEJIPjQrFzewaGNFyp327RJu24HhyIZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
X-Rspamd-Queue-Id: A217721FE7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9292-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,nxp.com:email]
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Thursday, March 5, 2026 9:34 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> mode
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Mar 05, 2026 at 12:15:41PM +0000, Verma, Devendra wrote:
> > [Public]
> >
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Wednesday, March 4, 2026 10:26 PM
> > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > > mode
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Wed, Feb 25, 2026 at 12:06:12PM +0000, Verma, Devendra wrote:
> > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > >
> > > > > -----Original Message-----
> > > > > From: Frank Li <Frank.li@nxp.com>
> > > > > Sent: Wednesday, February 25, 2026 3:58 AM
> > > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add
> > > > > non-LL mode
> > > > >
> > > > > Caution: This message originated from an External Source. Use
> > > > > proper caution when opening attachments, clicking links, or
> responding.
> > > > >
> > > > >
> > > > > On Mon, Feb 23, 2026 at 04:40:07PM +0000, Verma, Devendra wrote:
> > > > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Frank Li <Frank.li@nxp.com>
> > > > > > > Sent: Friday, February 20, 2026 9:33 PM
> > > > > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > > > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > > > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > > > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > > > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add
> > > > > > > non-LL mode
> > > > > > >
> > > > > ...
> > > > > > > > But if it about writing a new function to check the LL
> > > > > > > > mode support then I think the current variable is good
> > > > > > > > enough which provides good readability and do not create
> > > > > > > > any ambiguity compared to the ll region size
> > > > > > > comparison.
> > > > > > >
> > > > > > > It is not big deal,  use 'bool cap_non_ll: 1' in dw_edma_chip=
.
> > > > > > > So we add more cap flags in future.
> > > > > > >
> > > > > > > Frank
> > > > > > >
> > > > > >
> > > > > > Hi Frank, could you elaborate what you mean by adding the cap f=
lag?
> > > > > > How it is going To help identify the overall chip state?
> > > > > > I do not understand what is being implied here.
> > > > >
> > > > > non_ll in chan means current status, which indicate one channel
> > > > > work at non_ll mode or ll mode.
> > > > >
> > > > > here dw_edma_chip means hardware's captiblity, indicate if
> > > > > hardware support ll mode.
> > > > >
> > > > > Distingiush hardware limition or current working mode.
> > > > >
> > > > > Frank
> > > >
> > > > Thanks for the explanation!
> > > > Hardware supports the LL mode / non-LL mode, just that there is no
> > > > piece of code available which can perform the non-LL mode as only
> > > > one mode was supported initially by the respective developers.
> > > > So, providing it as capability does not look justified as in any
> > > > scenario hardware is capable of non-LL mode. Theoretically, non-LL
> > > > mode should have been the default mode.
> > > >
> > > > The non-LL mode is not a hardware limitation either. LL mode needs
> > > > extra configurations and in the absence of that, interpretation
> > > > could be, enable the supported other mode which is non-LL mode.
> > >
> > > Yes, that's reason why I don't want to add non-ll in dw_edma_chip,
> > > which should provide hardware's information.  non-ll actually miss
> > > ll_region information.
> > >
> >
> > I think, non_ll can be interpreted without using the ll-region related
> > information as well. My view regarding the dw_edma_chip struct is
> > slightly different, it does not provide the hardware capability rather
> > stores a snapshot of configuration based on information provided by
> > different means, please take a look at my comment below related to this=
.
> >
> > > >
> > > > With the current non_ll inside the dw_edma_chip, when non_ll =3D
> > > > false, indicates It supports both the modes LL and non-LL, but
> > > > requires user
> > > inputs to enable it.
> > > > With non_ll =3D true, the dw_edma_chip or the hardware has no choic=
e
> > > > but to work in non-LL mode only. This is the interpretation for the=
 flag in
> non_ll.
> > >
> > > we need distingiush current state and HW/SW captiblity. in dma_chan,
> > > non_ll means current working state.
> > >
> > > but the same words 'non_ll' in dw_edma_chip is HW/SW capablity.
> > >
> > > dma_chan: non_ll       means current channel use LL OR non LL.
> > > dma_edma_chips: non_ll means only support non LL mode OR both.
> > >
> > > The same words "non_ll" means difference. We should try to avoid this
> case.
> > >
> > > if you want to add field in dw_edma_chip, avoid use the same words
> > > because their means is difference.
> > >
> > > Frank
> >
> > Can we please simplify this interpretation, the non_ll in all the
> > scenarios should mean non-LL mode only if set to true.
> > dw_edma_chip : non_ll =3D true, it shall mean that all the channel, at =
chip level,
> can work in non-LL mode ONLY.
> > dw_edma_chan: non_ll =3D true, it shall mean that individual channel is
> configured for a transaction in non-LL mode.
>
> When read "a->non_ll", need good back check what type of a to know which
> one.  if use difference name
>         a->non_ll;
>         b->cfg_no_ll;
>
> It will not think more about what is a/b.
>

This suggestion is taken. I will push in next version of patches. Thanks!

> >
> > Above all, a nice comment related to the flag shall be good enough to
> > make the understanding clear, at the places where declared.
> > Since the beginning my emphasis is that 'non_ll' flag should be treated=
 for
> what it implies, i.e non-LL mode.
> > It was included in two different sets of structs to show the hierarchy
> > how it could affect the overall functionality depending upon where 'non=
_ll' is
> set to true.
>
> > Coming to the dw_edma_chip struct, I do not understand why the
> > dw_edma_chip struct is about hardware capability, it is more about the
> > configuration of the chip which is filled anyway at the time of
> > probe() function calling. This struct does not provide any capability
> > information at the time of probe() calling rather it is filled based on=
 the
> params configured by user either as static info (eg: snps_edda_data) or b=
y
> reading the capability registers (eg: VSEC and channels enabled by readin=
g
> config space).
> > I hope this clears the doubt. Please let me know if any further
> > information required related to the non_ll flag Interpretation.
>
> I don't want to take more time at this kind small stuff. I am fine if vno=
d Or mani
> (who pick up these patches) think it is okay.
>

Frank, could you please approve the patches if changes look ok to you?

> Frank
>
> >
> > Regards,
> > Devendra
> >
> > > >
> > > > With the capability, would it not make the statement, that if
> > > > non_ll =3D true, it supports non-LL mode but that does not mean to
> > > > be mutually exclusive and not support LL mode at the same time?
> > > > If there is a requirement regarding the capability then it can be
> > > > taken as a separate update but I am not sure what purpose it can
> > > > serve wrt
> > > non-LL functionality.
> > > > Please let me know your thoughts on this and lets conclude.
> > >
> > > >
> > > > Thanks!
> > > >
> > > > > >
> > > > > > - Regards,
> > > > > > Devendra
> > > > > >
> > > > > > > >
> > > > > > > > > Frank
> > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Frank
> > > > > > > > > > > > > > > >  };
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > > 2.43.0
> > > > > > > > > > > > > > > >


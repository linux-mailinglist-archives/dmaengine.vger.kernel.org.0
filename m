Return-Path: <dmaengine+bounces-11186-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6i6zKD65ImoHcwEAu9opvQ
	(envelope-from <dmaengine+bounces-11186-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 13:55:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FEB647E1C
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 13:55:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=grcfvlI1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11186-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11186-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E92630265AE
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6744D98EF;
	Fri,  5 Jun 2026 11:48:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496214D9900;
	Fri,  5 Jun 2026 11:48:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660093; cv=fail; b=L6q8HhBqm5yRzcD65rAWp9rV/PeKLfNn832tGJdpsq17If0IP3wg9OIxLWSAdrHdzAmJ5fuv8R7EBAH8DW80EJSPwxZsiaQKXHstBlwFBAgZzldRhZgaEDyV1S/9VpDp9yemwt8O9m874aSB9uqQBKvwoY/zgNQI3GeECioOinI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660093; c=relaxed/simple;
	bh=tWelAlO4e7DV04SgLYOsrpflTPFlFsVea5VqcMpahn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXxy1hQ0zr5g9GQ5qZfxwqiMHoHuHCrO7sSCCBa0BA19scZdhmrCY1/a3jJKhPkOmCaHblrnLEPoQdw5ggFhxQRX8Ko6PGOIf8fhEFC8rxNWcuAjJh95z+wsCIkzeCT7jhSHJcfizIUWrFQsuuvlWueetWOhtXYSurYlGPZg1F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=grcfvlI1; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZedRZVjWLR07W08rxERe8/w5qA1jDx2s3ng4YOJrDjq82CA3DweskKMHlAUZhLhFESLA9+JNT9gB8letIo0DU6wQkEmerfO5kyMvQBp3aLXu04XcFhZCPhnfzwoAMkS8UIYP+xPlnFNouHmmy71apvZsJSlZzAKdbKgmb4xHytVfA4jS9oFdd13wymFr/uTM6zboRwOas8MRf4T1EUAQxb8riPugRkdTbg0PPW5NTdZiK/FD2UJhdMy4YCabAyR5nVl3Px6KRZcvPkiiauUd7WQ2Dekg1jhKIKGWV5+a4Mf1F+icZQ27g6G1DgZF1pJavzbhB0cbInENHuLfD36UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AYitUeaxzf1wBhmpdDcLqKLSBWfch7LYITNZh1hcHE=;
 b=CTi6M7wnT5SeW3ebAdaCbLR5Ko01MuaF8hnY6WkaY/Yy0kIxY6iukDX8F5b3k1Sguum+q0s635J2ziJ6yCNuGXLaA3t0rTyhiQcdqKaM3Qj+5QGjktRu6udSoAl5HuZKL/i5U85s7aV10DWiEvXHOws7DKlT6un/9yD5c/UPAv5CBxnIctuBBML902zXPusygum88jVBFzR2vAixR3JxYMWvVejVRzaobRl4MKDUdQzkoRj6U9lJtpgoBNH8Q+6ZXoRMRu270/xfayaIVl9IRd0WtcbwaIFsHZjkbQTXxq79xhmw/beKWgAx2lkrqyYp1M5iPTzzAhGB4s4vPlsQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AYitUeaxzf1wBhmpdDcLqKLSBWfch7LYITNZh1hcHE=;
 b=grcfvlI13j7QJG8jT4RLCmedWuO5N3vI72aqQN+LpU+qFG1gtkWMTlJJbNeTrc2q7+LPi+LIbtukeakE6+nPcxM2W0qQ6vQkFgAYs2f3r3w9hQm+jPvNrszotOL//00Zud+l72iwUtlDabcOPO3+a9Lqx5PRJjyO7XjnX7axIzw=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by CH1PPF4C9628624.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 11:48:05 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 11:48:05 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Thread-Topic: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Thread-Index: AQHc82cfn7QgO5h/VU+JEJ5JddgQKbYu0jiAgAED+UA=
Date: Fri, 5 Jun 2026 11:48:05 +0000
Message-ID:
 <BL4PR12MB94822DC255780FF60297532595112@BL4PR12MB9482.namprd12.prod.outlook.com>
References: <20260603144147.3249691-1-devendra.verma@amd.com>
 <aiHY5V937ygrQ7Zt@lizhi-Precision-Tower-5810>
In-Reply-To: <aiHY5V937ygrQ7Zt@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-05T11:47:56.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9482:EE_|CH1PPF4C9628624:EE_
x-ms-office365-filtering-correlation-id: 7e391eb3-53fe-4898-63be-08dec2f84e85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 jvKPYoQR5wP3803UqYv32vUvU9Dl/CFHpYUvXhCaLu87mCvA/NpQVCUDSRuCMF+nRi9X+5d66FVW9E3TWbYM3YcYjZmb8dz7YwwxUoFfjRaj1hWjXGPOpRPGA5c92V4bwafqBHeX2WhPI6mAPoiha8lKSL9BjKzspljK55lnsYVONerVF4Mid181DcuvmAjnK61RAtUij5jtudvqlind/mTX7sCa9Cfbgc4OvPptR78TDsG+2BqMjuMxdFD02hsj4ADJdBZZUVxMhQ6s7jcADyzplfXrL2MELT4fDiXFL8pBu4bUC8MMAhprlgL0mL5uL3USzgi9BumMoKewPy3bsEMs4SWXdQpFmqNz4CXCKAjWuh2IlLEWqAUqmqfzyxSE1HXH3486ONrFkJSF4cW0BnJ8sge+9veb93aNrGyowkM58eSPiqVmsrzFqfq5LvpQjsWIhpDODyff54HLmQnlOa21ekbwe82bDckO0h3n9/IJzeRcy9pWh5oZL6s5Wg4nLUIhB4ou7w5uiuMqTojms3/wifR05d5i4RBzsRr68WtmxccTFXJY/UGI9BZ1b5ap37FWZ969ueJvcd7sMMLxzA/flkUuxdaAeWsQwESjz3JEgovSYotLW4gNBy81zoQlHtTHauP7FB45CKAm0xhDKIUHAo4UjakxNvxo34fEij7qe3RNCleizmKQBRiK1hNLQrw6FgJsXAu0Fo9Shl3A26eVccMMXGQeKznvYnvv2XGINDQ/t9bpvc9lGv7Ev8Q8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1lyy2nv5FmuoWWHtNA4Z5ROIf7rLQoUAjbll79hgwI8/vcbWvhqCwc+z2i+G?=
 =?us-ascii?Q?JWDUgi9mG2JrUNNQVOSFp2ktLBUPF0zdPPWkgOZ/cyXGj1qKZobQRio3hB0D?=
 =?us-ascii?Q?c33e2lk959uSyneMJdkqsSa+5Perf8FH2uhz/t3JUZlyapM20o7di4JDWk4y?=
 =?us-ascii?Q?dUudLYJjamWA98RJgNdBk5hOE+8WKSpWt4L3Q/6gOz7jLI5+wE6lEdgvjMHo?=
 =?us-ascii?Q?LbtwvaTUljUZ7vbHoPL+L569jWVB31aJG4+OW4l5SWexuBwc8bOq3qB9LDK+?=
 =?us-ascii?Q?55HdnOD/9O+4TjL3hBFw5ygJHsWOLRwHcIty5pc/BptAGf9MK7iJPqp087Iu?=
 =?us-ascii?Q?pu4J2kC/XJBZdyn3ULy2s0PUDLzojcgosn4C3TktK+6x3gQlJqENhnXC20Sr?=
 =?us-ascii?Q?oeX2KeCSlnYekkjWkE083M4iBcnSa0CYSDL4dd6fFabYn3QCCJrhelbl7OVM?=
 =?us-ascii?Q?yRsgKiek0jkcUNh8wMsQcQKTGmt+SIn+s2TOjAzW/3KY0BHn1NeNwoJTY82O?=
 =?us-ascii?Q?ZcU03c+d9QKnJNeRQtvT/NtJbI0TrMkCf/kdM0WYtNvf3J8BcvT8B78BUEsH?=
 =?us-ascii?Q?5Mms2GkA9tD6j2p1TxO5lTmoIWDlOpJNaMGCV6/F5NKJCNZmCwFd6xTdUNNx?=
 =?us-ascii?Q?khME3OADp5SsmKhL7OUgoJNvbGxx2Uzhz13B1D3HHedg8IsiBCNGgrl4uPx8?=
 =?us-ascii?Q?zflEW8nnCFOJKtkJM3P1p/4aGwaAovUawCAShatEQHyIzZ/w639P9thpwYw7?=
 =?us-ascii?Q?4iX2hpa+QZnmnmpNPRaLVxjqnks4oCqvRZd8Iub58ad6vrl4al8VMVw8pJCT?=
 =?us-ascii?Q?rlgjvQuIkHISb/xgNsDR5mV5nQrHAF49JOBEkHy0lcJvRqEFnmeL7s4VGecf?=
 =?us-ascii?Q?JXj0naj9CoM/2HgNSshNhFrnnTbWhBDBhHVoEkc3DPjZlBUMTMOm0qVwcyQR?=
 =?us-ascii?Q?UKilW4f5b6RYGhlEHm8mgsZqSNE+S4xQXkNvy06ifjXVpFToDT0NhU/zjNmq?=
 =?us-ascii?Q?x7+iZb4sOO7ZYxlZqslRxmAjreAuJu0L/ZCJV+rKTgE8aA13CYUa2CRdaQwH?=
 =?us-ascii?Q?QAjq8rREha3KkeuHSjoN1v5yRG2ydr/p9ip2nAQzTeL85rkm65J/b7BrNaC+?=
 =?us-ascii?Q?Lba4qZfaKJ1+DZxEr5djRvpYmbQ2BI5m2a+Rd9XcIpGZwoK3uDfZkpmWTY1C?=
 =?us-ascii?Q?7+5dPXDSnfq2t0Gxgb2AHSDmuggConuZD4GJppvsZuvUjksHpyWQ8jLL3soo?=
 =?us-ascii?Q?rJlYwJ33Lzo5Rzj2ZV6DuUuOym1zl7spVKsk7400pXpdnLj4m0rTX8y777Nh?=
 =?us-ascii?Q?BgUwEGqOMirkv3GIkGq0F9R9lyec8Vjs0l6rkaOb1GmgJ8bTCwPAvwmeewFx?=
 =?us-ascii?Q?9KqSraeBQNK5qfNczI3aPAOmzB2qdtUOJaLT6LVClrMkWZCpmaiHE1PavN3C?=
 =?us-ascii?Q?bX48nX60g3E2YF4d2Xd3HgZKYZ9ThyBBoD1+17VF5oj4dxPc6rHfIe28ljkP?=
 =?us-ascii?Q?m/3mtxv+6EylurrVPWBl4xd8yADCJE+hlICT+8nzlJG/dNRsCOgSEXSa61oZ?=
 =?us-ascii?Q?9TIxcKFGJe1tddI722SVWVKTzL1N92cTRPIazk/y2M5mFRLziIMOFBDxJa1g?=
 =?us-ascii?Q?DmFCOLuOJ0tj6Oc4T+/4ph2yMNPSAbG8DIPWyiMV+KS9w5+6w6hbYvMQHa3d?=
 =?us-ascii?Q?fv1+CkhOYSmxGY4LHd1+RzsLZNaeOgRzVH0F8Lk0yes8mkt9?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e391eb3-53fe-4898-63be-08dec2f84e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 11:48:05.7716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NI+LA4/BWMwQjwhdpwgIIaBE0d87xmeJn4LmfexRVYSklonBNgXJGgHgdP1Gow1adSrCvi7YX1deijnaPTW6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4C9628624
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
	TAGGED_FROM(0.00)[bounces-11186-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BL4PR12MB9482.namprd12.prod.outlook.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3FEB647E1C

Public

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Friday, June 5, 2026 01:28
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> Frank.Li@kernel.org; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W
> Channels
>
> On Wed, Jun 03, 2026 at 08:11:47PM +0530, Devendra K Verma wrote:
> > As per 'Designware Cores PCI Express Controller Databook', Section 7.1
> > - Overview, HDMA supports 64 Read and 64 Write channels. Current
> > controller driver supports up to 8 read and write channels only. In
> > order to utilize all the channels the controller driver need to have
> > the channel related structs and variables as per the number of
> > channels supported by IP.
> > Following changes are made to enable 64 Read / 64 Write channel
> > support:
> >
> >  o Defined HDMA specific macros to reflect the channel count.
> >  o The count of ll_regions and dt_regions in dw_edma_chip and
> >    dw_edma_pcie_data shall be in accordance to number of read
> >    and write channels.
> >  o In dw_edma_probe() configure the channels as per the channels
> >    of the IP used.
> >  o Changed mask types to u64 for higher channel counts.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> > Changes in v2:
> >   o Fixed the pre-existing bug related to GET_CH_32
> >     interchanging the channel direction and id.
> >     This bug was not caused by any version of this patch.
> >   o Fixed the issue when using for_each_set_bit() for mask
> >     of u64 type.
> >
> > Changes in v1:
> >   o On review recommendation of sashiko bot, in the function
> >     dw_hdma_v0_core_off(), the loop iterates over registers
> >     as per the number of channels enabled and not on total
> >     number of channels supported.
> >   o Changed mask types to u64 for higher channel counts.
> > ---
> ...
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum
> dw_edma_dir
> > dir, u16 ch)  static void dw_hdma_v0_core_off(struct dw_edma *dw)  {
> >     int id;
> > +   enum dw_edma_dir dir;
> > +
> > +   dir =3D EDMA_DIR_WRITE;
> > +   for (id =3D 0; id < dw->wr_ch_cnt; id++) {
> > +           SET_CH_32(dw, dir, id, int_setup,
> > +                     HDMA_V0_STOP_INT_MASK |
> HDMA_V0_ABORT_INT_MASK);
> > +           SET_CH_32(dw, dir, id, int_clear,
> > +                     HDMA_V0_STOP_INT_MASK |
> HDMA_V0_ABORT_INT_MASK);
> > +           SET_CH_32(dw, dir, id, ch_en, 0);
> > +   }
> >
> > -   for (id =3D 0; id < HDMA_V0_MAX_NR_CH; id++) {
> > -           SET_BOTH_CH_32(dw, id, int_setup,
> > -                          HDMA_V0_STOP_INT_MASK |
> HDMA_V0_ABORT_INT_MASK);
> > -           SET_BOTH_CH_32(dw, id, int_clear,
> > -                          HDMA_V0_STOP_INT_MASK |
> HDMA_V0_ABORT_INT_MASK);
> > -           SET_BOTH_CH_32(dw, id, ch_en, 0);
> > +   dir =3D EDMA_DIR_READ;
> > +   for (id =3D 0; id < dw->rd_ch_cnt; id++) {
> > +           SET_CH_32(dw, dir, id, int_setup,
> > +                     HDMA_V0_STOP_INT_MASK |
> HDMA_V0_ABORT_INT_MASK);
> > +           SET_CH_32(dw, dir, id, int_clear,
> > +                     HDMA_V0_STOP_INT_MASK |
> HDMA_V0_ABORT_INT_MASK);
> > +           SET_CH_32(dw, dir, id, ch_en, 0);
>
> why SET_BOTH_CH_32 not work for 64 channel?
>

SET_BOTH_CH_32 works, but this needs to be done on the channels enabled for=
 the IP.
HDMA supports maximum of 64 channels. So if some IP enables 8 or fewer read=
 / write channels only then the number of channels come from dw->wr_ch_cnt =
and dw->rd_ch_cnt. Now the logic is derived by individual read & write enab=
led channel count. Earlier, it was assumed that user will enable max of 8 c=
hannels which would have worked well using SET_BOTH_CH_32() but as the chan=
nels grow, the assumption that equal number of read / write channels and th=
at they are set to max count are enabled might not hold true.

- Devendra

> >     }
> >  }
> >
> > @@ -79,7 +90,7 @@ static enum dma_status
> dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> >     u32 tmp;
> >
> >     tmp =3D FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> > -                   GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> > +                   GET_CH_32(dw, chan->dir, chan->id, ch_stat));
>
> why need swtich id and dir here ?
>
> Frank

This is the correct order of arguments to the GET_CH_32. The second & third=
 arguments shall be direction and channel_id respectively. It is a pre-exis=
ting issue reported by AI bot.

> >
> >     if (tmp =3D=3D 1)
> >             return DMA_IN_PROGRESS;
> > @@ -118,7 +129,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq
> *dw_irq, enum dw_edma_dir dir,
> >     unsigned long total, pos, val;
> >     irqreturn_t ret =3D IRQ_NONE;
> >     struct dw_edma_chan *chan;
> > -   unsigned long off, mask;
> > +   unsigned long off;
> > +   u64 mask;
> >
> >     if (dir =3D=3D EDMA_DIR_WRITE) {
> >             total =3D dw->wr_ch_cnt;
> > @@ -130,7 +142,11 @@ dw_hdma_v0_core_handle_int(struct
> dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >             mask =3D dw_irq->rd_mask;
> >     }
> >
> > -   for_each_set_bit(pos, &mask, total) {
> > +   while (mask) {
> > +           pos =3D __ffs64(mask);
> > +           if (pos >=3D total)
> > +                   break;
> > +
> >             chan =3D &dw->chan[pos + off];
> >
> >             val =3D dw_hdma_v0_core_status_int(chan); @@ -147,6 +163,7
> @@
> > dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum
> > dw_edma_dir dir,
> >
> >                     ret =3D IRQ_HANDLED;
> >             }
> > +           mask &=3D mask - 1;
> >     }
> >
> >     return ret;
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > index 7759ba9b4850..48e40efceb2e 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > @@ -11,7 +11,7 @@
> >
> >  #include <linux/dmaengine.h>
> >
> > -#define HDMA_V0_MAX_NR_CH                  8
> > +#define HDMA_V0_MAX_NR_CH                  64
> >  #define HDMA_V0_CH_EN                              BIT(0)
> >  #define HDMA_V0_LOCAL_ABORT_INT_EN         BIT(6)
> >  #define HDMA_V0_REMOTE_ABORT_INT_EN                BIT(5)
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> > 1fafd5b0e315..da7a5cc93ad4 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -14,6 +14,8 @@
> >
> >  #define EDMA_MAX_WR_CH                                  8
> >  #define EDMA_MAX_RD_CH                                  8
> > +#define HDMA_MAX_WR_CH                                  64
> > +#define HDMA_MAX_RD_CH                                  64
> >
> >  struct dw_edma;
> >
> > @@ -89,12 +91,12 @@ struct dw_edma_chip {
> >     u16                     ll_wr_cnt;
> >     u16                     ll_rd_cnt;
> >     /* link list address */
> > -   struct dw_edma_region   ll_region_wr[EDMA_MAX_WR_CH];
> > -   struct dw_edma_region   ll_region_rd[EDMA_MAX_RD_CH];
> > +   struct dw_edma_region   ll_region_wr[HDMA_MAX_WR_CH];
> > +   struct dw_edma_region   ll_region_rd[HDMA_MAX_RD_CH];
> >
> >     /* data region */
> > -   struct dw_edma_region   dt_region_wr[EDMA_MAX_WR_CH];
> > -   struct dw_edma_region   dt_region_rd[EDMA_MAX_RD_CH];
> > +   struct dw_edma_region   dt_region_wr[HDMA_MAX_WR_CH];
> > +   struct dw_edma_region   dt_region_rd[HDMA_MAX_RD_CH];
> >
> >     /* interrupt emulation */
> >     int                     db_irq;
> > --
> > 2.43.0
> >


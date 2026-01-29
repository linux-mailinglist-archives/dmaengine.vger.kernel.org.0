Return-Path: <dmaengine+bounces-8579-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7XWXD85Ke2l/DgIAu9opvQ
	(envelope-from <dmaengine+bounces-8579-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 12:55:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BB4AFD34
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 12:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF94A3015731
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BA1385EE1;
	Thu, 29 Jan 2026 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d5n2BWA+"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DEC3793C2;
	Thu, 29 Jan 2026 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687755; cv=fail; b=uHmxC2z60Lc3mOxE+33vkWUio9HVCZUj+ZWc7axlxTNjxcJ7HeqsIt1cuQsgOFEwI2m+BshVI+hQv/Hy98tEfHp6wDefBJ3HseJVegHzKKR6U7OK6RoRxxN3fU6H+EaUMUEDXqfSHad7E8B08pXPEYVEnwFdmm6ZMEVGJ07C+qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687755; c=relaxed/simple;
	bh=GhjM53A3vkbAo/5jB2hvn3uUhYtlWefIjmPiTTFsxUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jV9/0Lk30aFvc8xdpBKyKd191qBRBbL0YKwHzbGI+1Nss9zG1mNyyu63ynSgzUVVLn2wQ9Qx4g4FBcaMg9GYNuckIE/ipVLaDbCV+DNlSre8EOUM+ZYYO8Dr5F38GTGXs6a9rB0rhb6nvLNh0EnEZwgGds3ETHQug1nh9xZm7jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d5n2BWA+; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJUbTgEC8ooayPEov+RPX8ANYV2E3ws67HOPeADPc9yfHQbX6npnYb8Le5hFz0paKG1j5oJBJl68NRU4tXdwyQXE4OKjjK5UWfh1jnO6eK5ryTnOurb/sV4BC21pstHCbzuTZAxI5fQKeRvclmH2+bwMCy9Vb8LO9cqc4crxMarCfMqM4WRT4IaZLUkjb3roVvunau9oedQRV94eTO34PkX+riZ44sMQPhp8eUgJp1qP6ruzJFRgElX360LxZexw4tyXtkmhFZi+5XI377P6wKP3vwAax+40gu7o1gZlOvOzN+CLcSokWdZffASynuDUFG9s2+9YKPtGFzUSJRPvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8N/Q5KCd0urI5M3C8mxm8GkXDEjs1f+xCymw2T73+k=;
 b=QrVg9jEs/vYC84PtSfTdHL7hxJdAdOO2hSjyyRMcQr74H4ZxQGUM2iuIo0pwRaqtxCrsxDuINMCagnBB63Tbgn5GwgHRmKlVqh4jEi293y1nI18tLvp+MJFgfT9Zg1GQBsCg2KMWazu/hk8V5d/eI+/zFEb4HoBrGTuOfMknp4vPTXuzzYSn1v+EySyrTWNudulgW2LjoCwWZ6DkX0oEtUM6ySVPsvXKiBzi7TB7GdNSysytub6Je/upIJ0ZfGk5/JXGBjQMGjRvFoelFrzW3bQ3Kra+tQkX/rue8O8ZuSRLM88tby3BuqyZeBh0L2eUyIgMOYHGoFaPuDVi2+mTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8N/Q5KCd0urI5M3C8mxm8GkXDEjs1f+xCymw2T73+k=;
 b=d5n2BWA+w8WAEJdVM6h0bph7+GfINts7/50iAA3JH+k+8W2jl57M+9TSvhQu9yynVuedHCKySrrAbtrmfjfWKPJ/dQZWLNmzCGdC8lIf71Vgf8jzjC81w3eZXMZN52/0WWV8EFFnKLvSNvE05etrCNwqahYC7dv+zK6uy1Q6vLo=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 11:55:50 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 11:55:50 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index:
 AQHcgWAk7pWjXdcU0UqtyDITzRPgzrVTd7gAgAE23OCABQPxgIABMzMAgAILjACAAQilwIAG704AgAJHbSCAAJxAAIABNRTQ
Date: Thu, 29 Jan 2026 11:55:49 +0000
Message-ID:
 <SA1PR12MB812089EE794D987D1AE48A07959EA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-3-devendra.verma@amd.com>
 <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F271FF381A78BEDCE6939589A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXEKeojreN06HIdF@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203BB877B64C4E525EC0269594A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120877E05B98E26B022C3669591A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXomMjSgrCucF/De@lizhi-Precision-Tower-5810>
In-Reply-To: <aXomMjSgrCucF/De@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-29T09:33:44.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|MN0PR12MB6002:EE_
x-ms-office365-filtering-correlation-id: f22f3bd8-ef79-49a4-07ad-08de5f2d58be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2pKCngjDHzJG51jTHDJslevQJypTLUi9gRgcg3hHfJu+BkVBYMQFOM69PiG9?=
 =?us-ascii?Q?sbWG3XDDPwtuFP5Kh0FxkX9MwHeU9WE8EagLGbowVpZA27ZvJnbKR0XtGadh?=
 =?us-ascii?Q?bqQEZWRNC419cVvuqXASQka1oThjSHETadySYpMkjIiphJ9KnV5/rOBnu2Nd?=
 =?us-ascii?Q?KZEhC1RmsS/vAyBpfdXhMFCw8LSFX6DJ10ZFlOOeqGk+YsanP1Bl1fSiNSSl?=
 =?us-ascii?Q?nwDTFO3uTmLpC6OfZSf9ShSzo8bk+SLUgAGQ4JPEKHYYrfCLHqaXcP0lqYAq?=
 =?us-ascii?Q?LjJnZdaZyEcpsQa0szbLbNRyQYVSHByz26LX4hGnwxyK+masYUEtTAZ2zyuo?=
 =?us-ascii?Q?/oFlQGkihrLH+NnqwWqreco9QPzhrlhgmYUraW8obyGW1tr1IyYyOJKWT1z5?=
 =?us-ascii?Q?SaGZkEpr+BQdtBoH/XqV8OkocUxVDvgx1ebjieqiCzXdQFff+ZaZcyiDFfUJ?=
 =?us-ascii?Q?kB3kW+HntDARVR8dAyJD8tRZS+S9L+K5IBJMb5s2NEk7Pv9MWovqTCj0n5R1?=
 =?us-ascii?Q?/EyczfW6WI1Deai8aMD+MNV+LILP5sTBCMwTogVsA0Gvc5ea5WhEqdU58SiE?=
 =?us-ascii?Q?El00USrjIt0kDwVQvKmnDmWiQDJ+58Y6Q15ov07gCfx/6zoLJP72MbErjQSh?=
 =?us-ascii?Q?8qJTectsNAQyniZ1ao4ecmb0vJLxIZZVAel/45INFmkZpnWhn89fS6ajf9YR?=
 =?us-ascii?Q?i27Mnl/qrLXGgxUvwtg+xgDPvxaVHLhTOwI68WY0xuCuRJu8ZPS1OJcFdoF5?=
 =?us-ascii?Q?/WU1dzo5flbPf0MSOZdSqKJE39ZDkHWwdbuK7Q/8fFxy8NT02BZnZgsBRFFt?=
 =?us-ascii?Q?CCISrgIF+jPy+h3qccurCkK9d0l1OL7rLzXFIc2fuGWsOrUI38GoLc/JPl+e?=
 =?us-ascii?Q?YHJOT4OkD+cXWl4cgC2bF+EwtOeNxCpv0L1jNyK/oXFdqGwYvCPOkaIYca5y?=
 =?us-ascii?Q?nKtx4IDDz+rcxxLbp+kcDxKLP/bEOnUjT9UVTqZ6XvUexh9T55Twz6LKVFcS?=
 =?us-ascii?Q?zoVVLEXdsj32UfpWEYBITkysRUfnZ5Cr3DbmSt56ebipYPDHb8QQYYeGu2e4?=
 =?us-ascii?Q?hmxDepUHWpQmmR2UnmUDE/3VJB9xlIbrRJ6NhV4wwP/z3cgRRV+nsA7v2OPY?=
 =?us-ascii?Q?FqJBHR4S4M4xI4FNYqZTbuxOZHr3UG0vrHEo4L1ALsASYqgZ8qGwmr5xnvgO?=
 =?us-ascii?Q?IyBLh5GqGcIWjNjq8B7xVKOfWPR9xqjKIFOYvbzmWXwzCLzRu9gYNhPKv//D?=
 =?us-ascii?Q?c2AGkll8B6LiqJbhl8S0bhgEy526aqgCjMyZSDGjz2OUKc3mcH9R6USgEc6D?=
 =?us-ascii?Q?7gQ6CEYGXD854iAGnNc5h7/kISfsEFZphkXJlSr0xhFjHz7HPwfcyS2epVlg?=
 =?us-ascii?Q?vZ3jxu8/D2BgLXgDa42B4EHzOfJ4y+OZbHe6C90k+S9MJHhG4DF3u8cyZA0y?=
 =?us-ascii?Q?xQU6IjDAwzuDVcpMqz+rASlwRlEskoe4WJsZpdkdayH5R9kYcQfNEu0/Z0Og?=
 =?us-ascii?Q?4E+rXHpZjgHr2c2jr3d6Wgg3ZyUatS4xH9XR1YJ5THQRIotjM0I119rGPtgp?=
 =?us-ascii?Q?wQGrtSjXIsv2heMwQ6wu4VPkr7HhAKBC7Lc3Ol9C8acYO2LjxyjjqGZaZkHR?=
 =?us-ascii?Q?ZTjnToW/cWb92SCR3cZs9nKoFssBINjBlN43CIKNSGbk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fOMVF1ju7iJjlVH0m6NWxZfDvkVz8a1TCIZb4NBFZ9SN982z62StOoh51qJh?=
 =?us-ascii?Q?6iSuze0LWVHvi7urA6yqAEWkW0vqPr6fCECvQYnhKuiJQm+Byz4ybngjEQXY?=
 =?us-ascii?Q?Lw7+M8Z0Nb/7EIiSOaXhbDBJnuqSQdrXR/oAPnORDTZZrTzLSWWPczpyZ3HL?=
 =?us-ascii?Q?Rz30e0emkUvcbGvNTkQc5ntPYjY9dCvhYDNmFX7LSKWUHpQ8DhessixW6hAs?=
 =?us-ascii?Q?tWjAmIgf/MgtznC/JjfS7kEkvUSt+a9iHUy6L3LN73tdZLVEYQtVNpL5veDD?=
 =?us-ascii?Q?QI/S9EYNh7VpCa0FjL7k9EpE8bUKPZQ9G5iV7h6+5ZM/HbIIp6i0bnvUglQr?=
 =?us-ascii?Q?m2Q5FvLJaomjS6SiPZyZHYtzoSot4cY8olGhYC4CKlrRka8g7LLqDHKVBoT8?=
 =?us-ascii?Q?1X3Q6VWxXglfcwSAgNQHCa1Y1lv6sYAHDvxm3NQQr5kUdiSh3N/u4hAlkmIN?=
 =?us-ascii?Q?2e5vO+99tUdxODKyOX30QPIHJEM/5AUv77kuemqhoLFRCi/asUbwoc0Gdor0?=
 =?us-ascii?Q?cTx+DO0RcH23WW7VC+vm9iNc7/zBK99cvP8DBu9b15EqxgYarpV6/EiEQZrp?=
 =?us-ascii?Q?YqHasfKzXx4o3TsSUxtw3Kv/eSmES4K+e/R3yXksvXzSKtkrKUmumC1csKbv?=
 =?us-ascii?Q?+FywDq1dXRim2POg3BCYLDOIfFmLKG6oaebqaKQvO9Ey7GRHZL4vl4uNttTR?=
 =?us-ascii?Q?VHDQ9A72XKJ51a0sm/6qmWOKyIwSlnojiGg4EYCb+vhWHJT0iPvHd6HyRB3P?=
 =?us-ascii?Q?CgodGJurAg34HWqE+CjYZWtQcflkkY/iIRZ3tIRiOu4qTFmDLwwbWPBxZ41O?=
 =?us-ascii?Q?gMwgs5SThxHpfW5tcyXqaPxU+g3KIosmnq2uOb3HfpamDLidYcMnbA9PHhx1?=
 =?us-ascii?Q?4SXFsCyNRp3ZNfg+U5BgcGn5RdyP1/4VCgzykm/vGC0GBvsLz8vu+O0goBLM?=
 =?us-ascii?Q?hI3EnsRzXGmOq2OS5UDi6l5RfGYIWsoi94sV2u34jCJldkZcGLNayScP314w?=
 =?us-ascii?Q?wDeRmiwWtiHQ4n3XVQBhqjfr3xDi8GJC4RRmkUJ65Xog1F6cV8t6gTPwYBmN?=
 =?us-ascii?Q?5ZaFEnmBlvNO0lHPdZKjxNewcUeWX7cjbjr4TS+l3BVkRXoJ4VlQVrzvi2Gr?=
 =?us-ascii?Q?Bcy4IHJ6ZscZ5W5RTjCm3u9i30iRxaJOevXmpYxZQq3gry0eXbMX52eywCCd?=
 =?us-ascii?Q?f6tIS6+iFRtvxYNDECQ8Q/qb2lEtzmIMhUY/Wq6npF0QsbUJ3teEBraJMA2+?=
 =?us-ascii?Q?EHivq8TXitJ6vZL4YdtaTOc6GdQ2UBqIRSpZESWSwRA4yVZW+vux9wy273/L?=
 =?us-ascii?Q?6qJbV7nf2mnwn9sXg/qTJIwMmh3/OgO1oHuN7sSlbak1mWE3yI9LZKfFYlCZ?=
 =?us-ascii?Q?W4T6wmsYdKVYJkXdqgcywQ5MFrFhytfDy3q21I9whwAzkXvAw1REix2ffZJi?=
 =?us-ascii?Q?R29Y8DB+N4FSbH+jMg44UmaJYTqEz6mprgvlq39zEt5sxkwuf7ciuJiCZBik?=
 =?us-ascii?Q?9jdC0kCoNUq/t88D5tzC6Hup6TAmsr+WuEkT75+yXEimWl+eH9dVVeYy1T5Y?=
 =?us-ascii?Q?Q80uGUWn9v9xZprDJE6eoNKJmTcSS3sFonJlqvZYYZkJdrAkirO585oj8Xsy?=
 =?us-ascii?Q?UAxEOzxw+nUUqxnX/gNSF/MBtLrvoPCoiA2C3J1iSfCaMqFOaT1WSIXHzSa+?=
 =?us-ascii?Q?qtMuoX3eFV5x05PolZZ3+FSJq7P2alJcCoezDDnb0cr5141A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f22f3bd8-ef79-49a4-07ad-08de5f2d58be
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 11:55:49.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRRR2uDCgGoCzPCmeESE3lzL9dDogiyH9oarWChYs2FR7fZfDuWBCAsJIj9LsskPaCm7/q0Wx/1SXNgyHiDxAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8579-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:url,amd.com:email,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 80BB4AFD34
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, January 28, 2026 8:38 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode

--[ Snipped some headers to reduce the size of this mail ]--

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
> > > > > > > > > >   used in non-LL mode. For all the channels DMA
> > > > > > > > > > transactions will
> > > > > > > > >
> > > > > > > > > If DDR have not configured, where DATA send to in device
> > > > > > > > > side by non-LL mode.
> > > > > > > > >
> > > > > > > >
> > > > > > > > The DDR base address in the VSEC capability is used for
> > > > > > > > driving the DMA transfers when used in the LL mode. The
> > > > > > > > DDR is configured and present all the time but the DMA
> > > > > > > > PCIe driver uses this DDR base address (physical address)
> > > > > > > > to configure the LLP
> > > address.
> > > > > > > >
> > > > > > > > In the scenario, where this DDR base address in VSEC
> > > > > > > > capability is not configured then the current controller
> > > > > > > > cannot be used as the default mode supported is LL mode onl=
y.
> > > > > > > > In order to make the controller usable non-LL mode is
> > > > > > > > being added which just needs SAR, DAR, XFERLEN and control
> > > > > > > > register to initiate the transfer. So, the DDR is always
> > > > > > > > present, but the DMA PCIe driver need to know the DDR base
> > > > > > > > physical address to make the transfer. This is useful in
> > > > > > > > scenarios where the memory
> > > > > > > allocated for LL can be used for DMA transactions as well.
> > > > > > >
> > > > > > > Do you means use DMA transfer LL's context?
> > > > > > >
> > > > > >
> > > > > > Yes, the device side memory reserved for the link list to
> > > > > > store the descriptors, accessed by the host via BAR_2 in this d=
river
> code.
> > > > > >
> > > > > > > >
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
> > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 42
> > > > > > > +++++++++++++++++++++---
> > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46
> > > > > ++++++++++++++++++--
> > > > > > > ------
> > > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > > > > > > > > ++++++++++++++++++++++++++++++++++-
> > > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > > > > > > > >
> > > > > > > > > edma-v0-core.c have not update, if don't support, at
> > > > > > > > > least need return failure at dw_edma_device_config()
> > > > > > > > > when backend is
> > > eDMA.
> > > > > > > > >
> > > > > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > > > > >  6 files changed, 132 insertions(+), 20 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > index b43255f..d37112b 100644
> > > > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > @@ -223,8 +223,32 @@ static int
> > > > > > > > > > dw_edma_device_config(struct
> > > > > > > > > dma_chan *dchan,
> > > > > > > > > >                                struct dma_slave_config =
*config)  {
> > > > > > > > > >       struct dw_edma_chan *chan =3D
> > > > > > > > > > dchan2dw_edma_chan(dchan);
> > > > > > > > > > +     int non_ll =3D 0;
> > > > > > > > > > +
> > > > > > > > > > +     if (config->peripheral_config &&
> > > > > > > > > > +         config->peripheral_size !=3D sizeof(int)) {
> > > > > > > > > > +             dev_err(dchan->device->dev,
> > > > > > > > > > +                     "config param peripheral size mis=
match\n");
> > > > > > > > > > +             return -EINVAL;
> > > > > > > > > > +     }
> > > > > > > > > >
> > > > > > > > > >       memcpy(&chan->config, config, sizeof(*config));
> > > > > > > > > > +
> > > > > > > > > > +     /*
> > > > > > > > > > +      * When there is no valid LLP base address
> > > > > > > > > > + available then the
> > > > > default
> > > > > > > > > > +      * DMA ops will use the non-LL mode.
> > > > > > > > > > +      *
> > > > > > > > > > +      * Cases where LL mode is enabled and client
> > > > > > > > > > + wants to use the
> > > > > non-LL
> > > > > > > > > > +      * mode then also client can do so via providing
> > > > > > > > > > + the
> > > > > peripheral_config
> > > > > > > > > > +      * param.
> > > > > > > > > > +      */
> > > > > > > > > > +     if (config->peripheral_config)
> > > > > > > > > > +             non_ll =3D *(int
> > > > > > > > > > + *)config->peripheral_config;
> > > > > > > > > > +
> > > > > > > > > > +     chan->non_ll =3D false;
> > > > > > > > > > +     if (chan->dw->chip->non_ll ||
> > > > > > > > > > + (!chan->dw->chip->non_ll &&
> > > > > non_ll))
> > > > > > > > > > +             chan->non_ll =3D true;
> > > > > > > > > > +
> > > > > > > > > >       chan->configured =3D true;
> > > > > > > > > >
> > > > > > > > > >       return 0;
> > > > > > > > > > @@ -353,7 +377,7 @@ static void
> > > > > > > > > > dw_edma_device_issue_pending(struct
> > > > > > > > > dma_chan *dchan)
> > > > > > > > > >       struct dw_edma_chan *chan =3D
> > > > > > > > > > dchan2dw_edma_chan(xfer-
> > > > > >dchan);
> > > > > > > > > >       enum dma_transfer_direction dir =3D xfer->directi=
on;
> > > > > > > > > >       struct scatterlist *sg =3D NULL;
> > > > > > > > > > -     struct dw_edma_chunk *chunk;
> > > > > > > > > > +     struct dw_edma_chunk *chunk =3D NULL;
> > > > > > > > > >       struct dw_edma_burst *burst;
> > > > > > > > > >       struct dw_edma_desc *desc;
> > > > > > > > > >       u64 src_addr, dst_addr; @@ -419,9 +443,11 @@
> > > > > > > > > > static void dw_edma_device_issue_pending(struct
> > > > > > > > > dma_chan *dchan)
> > > > > > > > > >       if (unlikely(!desc))
> > > > > > > > > >               goto err_alloc;
> > > > > > > > > >
> > > > > > > > > > -     chunk =3D dw_edma_alloc_chunk(desc);
> > > > > > > > > > -     if (unlikely(!chunk))
> > > > > > > > > > -             goto err_alloc;
> > > > > > > > > > +     if (!chan->non_ll) {
> > > > > > > > > > +             chunk =3D dw_edma_alloc_chunk(desc);
> > > > > > > > > > +             if (unlikely(!chunk))
> > > > > > > > > > +                     goto err_alloc;
> > > > > > > > > > +     }
> > > > > > > > >
> > > > > > > > > non_ll is the same as ll_max =3D 1. (or 2, there are link=
 back
> entry).
> > > > > > > > >
> > > > > > > > > If you set ll_max =3D 1, needn't change this code.
> > > > > > > > >
> > > > > > > >
> > > > > > > > The ll_max is defined for the session till the driver is
> > > > > > > > loaded in the
> > > > > kernel.
> > > > > > > > This code also enables the non-LL mode dynamically upon
> > > > > > > > input from the DMA client. In this scenario, touching
> > > > > > > > ll_max would not be a good idea as the ll_max controls the
> > > > > > > > LL entries for all the DMA channels not just for a single D=
MA
> transaction.
> > > > > > >
> > > > > > > You can use new variable, such as ll_avail.
> > > > > > >
> > > > > >
> > > > > > In order to separate out the execution paths a new meaningful
> > > > > > variable
> > > > > "non_ll"
> > > > > > is used. The variable "non_ll" alone is sufficient. Using
> > > > > > another variable along side "non_ll" for the similar purpose
> > > > > > may not have any
> > > > > added advantage.
> > > > >
> > > > > ll_avail can help debug/fine tune how much impact preformance by
> > > > > adjust ll length. And it make code logic clean and consistent.
> > > > > also ll_avail can help test corner case when ll item small.
> > > > > Normall case it is
> > > hard to reach ll_max.
> > > > >
> > > >
> > > > Thank you for your suggestion. The ll_max is max limit on the
> > > > descriptors that can be accommodated on the device side DDR. The
> > > > ll_avail
> > > will always be less than ll_max.
> > > > The optimization being referred can be tried without even having
> > > > to declare the ll_avail cause the number of descriptors given can
> > > > be controlled by the DMA client based on the length argument to
> > > > the
> > > dmaengine_prep_* APIs.
> > >
> > > I optimzied it to allow dynatmic appended dma descriptors.
> > >
> > > https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-
> > > 9a98c9c98536@nxp.com/T/#t
> > >
> > > > So, the use of dynamic ll_avail is not necessarily required.
> > > > Without increasing the ll_max, ll_avail cannot be increased. In
> > > > order to increase ll_max one may need to alter size and recompile t=
his
> driver.
> > > >
> > > > However, the requirement of ll_avail does not help for the
> > > > supporting the
> > > non-LL mode.
> > > > For non-LL mode to use:
> > > > 1) Either LL mode shall be not available, as it can happen for the =
Xilinx IP.
> > > > 2) User provides the preference for non-LL mode.
> > > > For both above, the function calls are different which can be
> > > > differentiated by using the "non_ll" flag. So, even if I try to
> > > > accommodate ll_avail, the call for LL or non-LL would be ambiguous
> > > > as in
> > > case of LL mode also we can have a single descriptor as similar to
> > > non-LL mode.
> > > > Please check the function dw_hdma_v0_core_start() in this review
> > > > where the decision is taken Based on non_ll flag.
> > >
> > > We can treat ll_avail =3D=3D 1 as no_ll mode because needn't set extr=
a
> > > LL in memory at all.
> > >
> >
> > I analyzed the use of ll_avail but I think the use of this variable
> > does not fit at this location in the code for the following reasons:
> > 1. The use of a new variable breaks the continuity for non-LL mode. The
> variable
> >     name non_ll is being used for driving the non-LL mode not only in t=
his file
> but also
> >    in the files relevant to HDMA. This flag gives the clear indication =
of LL vs
> non-LL mode.
> >    In the function dw_hdma_v0_core_start(), non_ll decided the mode to
> choose.
> > 2. The use of "ll_avail" is ambiguous for both the modes. First, it is
> associated with LL mode only.
> >      It will be used for optimizing / testing the Controller performanc=
e based
> on the
> >     number of descriptors available on the Device DDR side which is for=
 LL
> mode. So when
> >     it is being used for LL mode then it is obvious that it excludes an=
y use for
> non-LL mode.
> >     In the API dw_edma_device_transfer(), the ll_avail will be used for
> creating the bursts.
> >     If ll_avail =3D 1 in the above API, then it is ambiguous whether it=
 is creating
> the burst for
> >      LL or non-LL mode. In the above API, the non_ll is sufficient to h=
ave the
> LL mode
> >      and non-LL burst allocation related piece of code.
>
> If really like non-ll, you'd better set ll_avail =3D 1 in prepare code.
> Normal case ll_avail should be ll_max. It will reduce if-else branch in p=
rep
> dma burst code.
>

I think we are not on the same page, and it is creating confusion.
If non_ll flag is being used to differentiate between the modes, then in th=
is scenario
the use of ll_avail does not fit any requirement related to differentiation=
 of different
modes. In the last response, I pointed out that ll_avail, if used, creates =
ambiguity
rather than bringing clarity for both LL & non-LL mode. If non_ll flag is u=
sed and
initialized properly then this is sufficient to drive the execution for non=
-LL mode.

In the function doing the preparation, there also no if-else clause is intr=
oduced rather
the same "if" condition is extended to support the non-LL mode.

Could you elaborate what is the approach using ll_avail if I need to mainta=
in the
continuity of the non-LL context and use non-LL mode without any ambiguity =
anywhere,
instead of using non_ll flag?
If possible, please give a code snippet. Depending upon the usability and i=
ssue it fixes, I
will check its feasibility.

> +               /*
> +                * For non-LL mode, only a single burst can be handled
> +                * in a single chunk unlike LL mode where multiple bursts
> +                * can be configured in a single chunk.
> +                */
>
> It is actually wrong, current software should handle that. If there are m=
ultiple
> bursts, only HEAD of bursts trigger DMA, in irq handle, it will auto move=
 to
> next burst. (only irq latency is bigger compared to LL, software's resule=
 is the
> same).
>
> The code logic is totally equal ll_max =3D 1, except write differece regi=
sters.
>

Changing the ll_max dynamically for a single request is not feasible. As po=
inted out
earlier it may require the logic to retain the initially configured value, =
during the probe,
and then use the retained value depending on the use-case.
Could you elaborate the statement,
" The code logic is totally equal ll_max =3D 1, except write differece regi=
sters." ?

The irq_handler() for success case calls dw_edma_start_transfer() which sch=
edules the chunks
not bursts. The bursts associated with that chunk will get written to contr=
oller DDR area /
scheduled (for non-LL) in the dw_hdma_v0_core_start(), for HDMA.
With this flow, for the non-LL mode each chunk needs to contain a single bu=
rst as controller
can handle only one burst at a time in non-LL mode.


> And anthor important is that,
>
> in dw_edma_device_config() should return if backend is not HDMA.
>

Thanks, this is a valid concern, will address in the upcoming version.

> Frank
>
> >
> > I think ll_avail, if used for trying out to optimize / debug the
> > settings related to number of descriptors for LL mode then it should
> > be part of the separate discussion / update not related to non-LL.
> >
> > > >
> > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > ...
> > > > > > > > > > +
> > > > > > > > > > + ll_block->bar);
> > > > > > > > >
> > > > > > > > > This change need do prepare patch, which only change
> > > > > > > > > pci_bus_address() to dw_edma_get_phys_addr().
> > > > > > > > >
> > > > > > > >
> > > > > > > > This is not clear.
> > > > > > >
> > > > > > > why not. only trivial add helper patch, which help reviewer
> > > > > > >
> > > > > >
> > > > > > I was not clear on the question you asked.
> > > > > > It does not look justified when a patch is raised alone just
> > > > > > to replace this
> > > > > function.
> > > > > > The function change is required cause the same code *can*
> > > > > > support different IPs from different vendors. And, with this
> > > > > > single change alone in the code the support for another IP is
> > > > > > added. That's why it is easier to get the reason for the
> > > > > > change in the function name and
> > > syntax.
> > > > >
> > > > > Add replace pci_bus_address() with dw_edma_get_phys_addr() to
> > > > > make review easily and get ack for such replacement patches.
> > > > >
> > > > > two patches
> > > > > patch1, just replace exist pci_bus_address() with
> > > > > dw_edma_get_phys_addr() patch2, add new logic in
> > > dw_edma_get_phys_addr() to support new vendor.
> > > > >
> > > >
> > > > I understand your concern about making the review easier. However,
> > > > given that we've been iterating on this patch series since
> > > > September and are now at v9, I believe the current approach is
> > > > justified. The function renames from
> > > > pci_bus_address() to dw_edma_get_phys_addr() is directly tied to
> > > > the non-LL mode functionality being added - it's needed because
> > > > the same code now supports different IPs from different vendors.
> > > >
> > > > Splitting this into a separate preparatory patch at this stage
> > > > would further delay the review process. The change is kind of
> > > > straightforward and the context is clear within the current patch.
> > > > I request
> > > you to review this patch to avoid additional review cycles.
> > > >
> > > > This also increases the work related to testing and maintaining
> > > > multiple
> > > patches.
> > > > I have commitment for delivery of this, and I can see adding one
> > > > more series definitely add 3-4 months of review cycle from here.
> > > > Please excuse me but this code has already
> > >
> > > Thank you for your persevere.
> > >
> >
> > Thank you for your support.
> >
> > > > been reviewed extensively by other reviewers and almost by you as
> > > > well. You can check the detailed discussion wrt this function at
> > > > the following
> > > link:
> > > >
> > >
> https://lore.kernel.org/all/SA1PR12MB8120341DFFD56D90EAD70EDE9514A@
> > > SA1
> > > > PR12MB8120.namprd12.prod.outlook.com/
> > > >
> > >
> > > But still not got reviewed by tags. The recently,  Manivannan
> > > Sadhasivam , Niklas Cassel and me active worked on this driver.
> > > You'd better to get their feedback. Bjorn as pci maintainer to provid=
e
> generally feedback.
> > >
> >
> > Hi Manivannan Sadhasivam, Vinod Koul and Bjorn Helgaas Could you
> > please provide your feedback on the patch?
> > You have reviewed these patches extensively on the previous versions of
> the same series.
> >
> > Regards,
> > Devendra
> >
> > >
> > > > > >
> > > > > > > >
> > > > > > > > > >               ll_region->paddr +=3D ll_block->off;
> > > > > > > > > >               ll_region->sz =3D ll_block->sz;
> > > > > > > > > >
> > > > > ...
> > > > > > > > > >
> > > > > > > > > > +static void dw_hdma_v0_core_non_ll_start(struct
> > > > > > > > > > +dw_edma_chunk
> > > > > > > > > *chunk)
> > > > > > > > > > +{
> > > > > > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > > > > > +     struct dw_edma *dw =3D chan->dw;
> > > > > > > > > > +     struct dw_edma_burst *child;
> > > > > > > > > > +     u32 val;
> > > > > > > > > > +
> > > > > > > > > > +     list_for_each_entry(child, &chunk->burst->list,
> > > > > > > > > > + list) {
> > > > > > > > >
> > > > > > > > > why need iterated list, it doesn't support ll. Need wait
> > > > > > > > > for irq to start next
> > > > > > > one.
> > > > > > > > >
> > > > > > > > > Frank
> > > > > > > >
> > > > > > > > Yes, this is true. The format is kept similar to LL mode.
> > > > > > >
> > > > > > > Just fill one. list_for_each_entry() cause confuse.
> > > > > > >
> > > > > > > Frank
> > > > > >
> > > > > > I see, we can use list_first_entry_or_null() which is
> > > > > > dependent on giving the type of pointer, compared to this
> > > > > > list_for_each_entry() looks neat and agnostic to the pointer
> > > > > > type being used. Though, it can be
> > > > > explored further.
> > > > > > Also, when the chunk is allocated, the comment clearly spells
> > > > > > out how the allocation would be for the non LL mode so it is
> > > > > > evident that each chunk would have single entry and with that
> > > > > > understanding it is clear that loop will also be used in a
> > > > > > similar manner, to retrieve a single entry. It is a similar
> > > > > > use case as of "do {}while (0)" albeit needs a context to
> > > > > understand it.
> > > > >
> > > > > I don't think so. list_for_each_entry() is miss leading to
> > > > > reader think it is not only to one item in burst list, and use
> > > > > polling method to to finish many burst transfer.
> > > > >
> > > > > list_for_each_entry() {
> > > > >         ...
> > > > >         readl_timeout()
> > > > > }
> > > > >
> > > > > Generally, EDMA is very quick, polling is much quicker than irq
> > > > > if data is
> > > small.
> > > > >
> > > > > Frank
> > > > >
> > > >
> > > > The polling is not required. The single burst will raise the
> > > > interrupt and from the interrupt context another chunk will be
> > > > scheduled. This cycle repeats till all the chunks with single burst=
 are
> exhausted.
> > > >
> > > > The following comment made in function dw_edma_device_transfer()
> > > > in the same patch makes it amply clear that only a single burst
> > > > would be
> > > handled for the non-LL mode.
> > > > +       /*
> > > > +        * For non-LL mode, only a single burst can be handled
> > > > +        * in a single chunk unlike LL mode where multiple bursts
> > > > +        * can be configured in a single chunk.
> > > > +        */
> > > >
> > > > Looking at the way bursts are appended to chunks and chunks in
> > > > dw_edma_device_transfer() are scheduled for non-LL mode then it is
> > > > clear
> > > what non-LL mode would handle in terms of bursts.
> > > > I just kept the format to match it with the LL mode format
> > > > otherwise there is no need of this comment and we can follow the
> > > > syntax for a single
> > > entry alone.
> > > > Please share your suggestion if these descriptions fail to provide
> > > > the clear
> > > context and intent.
> > >
> > > Avoid use list_for_each_entry() here to prevent miss-leading.
> > >
> > > Frank
> > >
> >
> > Sure, thanks, I will push this change in next version.
> >
> > > >
> > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > + ch_en, HDMA_V0_CH_EN);
> > > > > > > > > > +
> > > > > > > > > > +             /* Source address */
> > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.ls=
b,
> > > > > > > > > > +                       lower_32_bits(child->sar));
> > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.ms=
b,
> > > > > > > > > > +                       upper_32_bits(child->sar));
> > > > > > > > > > +
> > > > > > > > > > +             /* Destination address */
> > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.ls=
b,
> > > > > > > > > > +                       lower_32_bits(child->dar));
> > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.ms=
b,
> > > > > > > > > > +                       upper_32_bits(child->dar));
> > > > > > > > > > +
> > > > > > > > > > +             /* Transfer size */
> > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > + transfer_size,
> > > > > > > > > > + child->sz);
> > > > > > > > > > +
> > > > > > > > > > +             /* Interrupt setup */
> > > > > > > > > > +             val =3D GET_CH_32(dw, chan->dir, chan->id=
, int_setup)
> |
> > > > > > > > > > +                             HDMA_V0_STOP_INT_MASK |
> > > > > > > > > > +                             HDMA_V0_ABORT_INT_MASK |
> > > > > > > > > > +                             HDMA_V0_LOCAL_STOP_INT_EN=
 |
> > > > > > > > > > +
> > > > > > > > > > + HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > > > > > > > +
> > > > > > > > > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCA=
L)) {
> > > > > > > > > > +                     val |=3D HDMA_V0_REMOTE_STOP_INT_=
EN |
> > > > > > > > > > +                            HDMA_V0_REMOTE_ABORT_INT_E=
N;
> > > > > > > > > > +             }
> > > > > > > > > > +
> > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > + int_setup, val);
> > > > > > > > > > +
> > > > > > > > > > +             /* Channel control setup */
> > > > > > > > > > +             val =3D GET_CH_32(dw, chan->dir, chan->id=
, control1);
> > > > > > > > > > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > + control1, val);
> > > > > > > > > > +
> > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, doorbe=
ll,
> > > > > > > > > > +                       HDMA_V0_DOORBELL_START);
> > > > > > > > > > +     }
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void dw_hdma_v0_core_start(struct
> > > > > > > > > > +dw_edma_chunk *chunk, bool
> > > > > > > > > > +first) {
> > > > > > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > > > > > +
> > > > > > > > > > +     if (chan->non_ll)
> > > > > > > > > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > > > > > > > > +     else
> > > > > > > > > > +             dw_hdma_v0_core_ll_start(chunk, first);
> > > > > > > > > > + }
> > > > > > > > > > +
> > > > > > > > > >  static void dw_hdma_v0_core_ch_config(struct
> > > > > > > > > > dw_edma_chan
> > > > > > > > > > *chan)
> > > > > > > {
> > > > > > > > > >       struct dw_edma *dw =3D chan->dw; diff --git
> > > > > > > > > > a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > index eab5fd7..7759ba9 100644
> > > > > > > > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > @@ -12,6 +12,7 @@
> > > > > > > > > >  #include <linux/dmaengine.h>
> > > > > > > > > >
> > > > > > > > > >  #define HDMA_V0_MAX_NR_CH                    8
> > > > > > > > > > +#define HDMA_V0_CH_EN                                B=
IT(0)
> > > > > > > > > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > > > > > > > > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > > > > > > > > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > > > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > > > > b/include/linux/dma/edma.h index 3080747..78ce31b
> > > > > > > > > > 100644
> > > > > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > > > > >       enum dw_edma_map_format mf;
> > > > > > > > > >
> > > > > > > > > >       struct dw_edma          *dw;
> > > > > > > > > > +     bool                    non_ll;
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > --
> > > > > > > > > > 1.8.3.1
> > > > > > > > > >


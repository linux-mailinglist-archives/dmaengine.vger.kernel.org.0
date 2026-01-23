Return-Path: <dmaengine+bounces-8464-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E6dKBSFc2kDxAAAu9opvQ
	(envelope-from <dmaengine+bounces-8464-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 15:26:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABEB77048
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAD3E301D97D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724483254A8;
	Fri, 23 Jan 2026 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wiJMImDg"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AA32D0C95;
	Fri, 23 Jan 2026 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178380; cv=fail; b=CapiYW+k6U/30KH5JvVJq8uv0ZcuWrYdXSVJOe4PYsQtUQk1Z199NDj8LLF67CJLP8QDMWA+A7LB2hdeN+8KhWsTQuMtEm8cQnZyDfkLNwlU64V0wXc+DgB3tDNrPe1QzDHt6Ap2jaVS4V0OrHhC74k1zgLkwGqBatra5u8pASI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178380; c=relaxed/simple;
	bh=AGVQ5GtY0c7HfqBUaZrNT6R8IN8kkQOv0yDx1wff+Eg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JLfocirqFSr0UQn/pOO7MR1XsDQ7QKtqfSAzFZnqhdyTzEEzEL/FtRnnFeC0qhz6ZNL2Re2wHAZCStWMI8kbEY/mINEgOyZuCwx4C6G3oRFqlawFaqvyVssUJ5Y4gpUblzVyVA+soOANMYmhp6YkrdMBq8sAwU1w4JUdrpzf92Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wiJMImDg; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q75DDz8z4l4js8FXjvXKcNpS1/UyBmVSzkGz/i8cBQDuacMoTM19sje6rNQiQZtPv4c/C2kyzb9X/vSzieZR7+LJpufwX5a89S96f3kSirboqhYvwA5PQy2MiixbIT46a/KPNxVSoolUMYDOMOOZle6uiORmrHBXLXyidhui/FWc0g+AfEcAYJefbwwACCPT162Ea9oe864GL+trcgh96Afht4jJTOYtaVcyPenCzjsFzB56ZFbNdhsq8QT4D1SVf6aJ+UWx2y0v6D9ZzuqwmQePpq8+CrI4g5n0pScMLpVfkWYFrajgbjLVq3PMZpyDy+XatKnzv5w2iSGl3AAIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CASBh/pRrf9k9mX10Rw1o15f59cMrtcQuGVrzkcERCI=;
 b=Fhat+6Sa388dVKfpMNGuP1dbF+9fcFP7lstefUf7zjf1a8mtvmmuxaJgD9uhRyjjUcU30UcbSN4LZAanCBWHdxMF1ZyWnuX2O4nkXATpnqASkznO0JqApFw0Jip4Owsgb3mQEn8byc6wehtp4qU8VmeP8l6uznI9kg8f1FHRAtfYUV2T5luuOwduKtvfGY/8EjQv/C3bYnCfuM+u1kpEviZ4QGk0GLqXLgO3vI4GQRvMMClWOl/VAEUqTr05IC2+C4olzF59CHwQXZYjwI9v7LqzEz2qEiUhNz4EN5duCdqBDItY1kIMsbMwxcYCVqlB4RwbuqkEUNnLxBKf0Bztwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CASBh/pRrf9k9mX10Rw1o15f59cMrtcQuGVrzkcERCI=;
 b=wiJMImDgNZ0kS+qVZY4xeFlsTGPuri3Ha0i8RkFXmois57BdO37iCz6FB5zlE2bcVnqKZZrLavUy7aU3cMca1qgMn1hlP2kqcgqXGvmmi5pd1q9wa7tik0yqb51KXWIQa8f9CnWNEDzqJ69PXw7tteVSwWVt12/7nggJy314fJc=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 14:26:15 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 14:26:15 +0000
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
 AQHcgWAk7pWjXdcU0UqtyDITzRPgzrVTd7gAgAE23OCABQPxgIABMzMAgAILjACAAQilwA==
Date: Fri, 23 Jan 2026 14:26:15 +0000
Message-ID:
 <SA1PR12MB81203BB877B64C4E525EC0269594A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-3-devendra.verma@amd.com>
 <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F271FF381A78BEDCE6939589A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXEKeojreN06HIdF@lizhi-Precision-Tower-5810>
In-Reply-To: <aXEKeojreN06HIdF@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-22T09:06:02.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA0PR12MB8837:EE_
x-ms-office365-filtering-correlation-id: 6fc98bce-cb7e-44d3-da86-08de5a8b5de5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IxigUqrFpFryXBPipxNun7PRf7sF2i6HKYYrE0lFy3ySgDCShtXz9OOxv1/c?=
 =?us-ascii?Q?lEmyg4uUS3jOveGk4DbTiOgMaEiOhXRrnr8JRyaiyXLt434uqMUvtNSawu7+?=
 =?us-ascii?Q?2dPxpQCx45dV8PnHo4xcRAtagl87wXPPZF9LyCOPF8EqGjn70sc9HSrkwTKn?=
 =?us-ascii?Q?mTvG9BOxTgM9EclEAXTg9iI5UzR76cQ8+TU2mshsUK0rZG6y2e6nDDPN/4kf?=
 =?us-ascii?Q?+emol6qcVdba/BOYa3zJyHoACbHUmI9Z0+JzWw89a1wsdLk7UCSiuQ210kCp?=
 =?us-ascii?Q?fTl9JpPFVbZloqHCDu/HpXxtzj9S29loEerqeF5/hjfUIQHPMijYaHH+QtXo?=
 =?us-ascii?Q?+KVKk+rk8VrX7t1aTCuShOLZ+IPRlO1vsRIyWUS+h/fKaqmUs4LcKUQ36cug?=
 =?us-ascii?Q?e66S6mNZLwtGc4cROSkwbKo+gEXOxIhKRaWWXu4u899srM58uxNIDQyLunjP?=
 =?us-ascii?Q?PIFFGcsszts2OW9Ua+QLu4pIwSObm2JRc6c3bacs0WzLxezBzy3VhoqMzrkX?=
 =?us-ascii?Q?yFYNISkSIIxlszeqr8kKFrM0ot5yaQ0f+NXm3YillenIpiOQjx9tnzCgGa38?=
 =?us-ascii?Q?lm4W76uJM+1t731O2l0d6WBLxqG8WRRngKf6j2z5skI5HwJW7OfDGmcDOLKg?=
 =?us-ascii?Q?H+fPKMp8YqjBmbqXDaHpvVtCSXbcsVFO7RpOCsdVpRf4WX4G6eBwXm4NLjSm?=
 =?us-ascii?Q?9Q74KMB+MzdD6bVjSiOQZw5Qgn/1BrJE8ptT/OCFlOn07n03AJb1jKjv+CT2?=
 =?us-ascii?Q?ZMKh5Y2arv0agJwYpN4/y+HN7xFoXpxDv3cjAeTDvey0Zx0XO2BPJ83g33Jl?=
 =?us-ascii?Q?F42uFncHRI4HXCQjV9qMJjdL/yOId2HkcdTZYc5Z6u5J4m5G+kKpGABIxS/p?=
 =?us-ascii?Q?RSizPA1xKCZ87Its/5Rgnbb5qUtE84UkAB2MrsVk5eUXC0T4zXMALcE2IVL2?=
 =?us-ascii?Q?330rvm5I76S01cP/MQFTc0JUoSQFYmSdh5CHxfm0DvtKrSBDOOz/J7bgsIOn?=
 =?us-ascii?Q?/p/O16upfVqqWG/UgHu0m5WYEIlnwAdL+dUWGNRWBx3JVSHuthY++kq9n2uC?=
 =?us-ascii?Q?HSDxNOU0PhwlgMXGag7aSBzVstvA5cAXzOjQtAchB1PzhfCFZwruALXL8u+v?=
 =?us-ascii?Q?Pfzn1rE9K+zaJ5QBpmV8FjgBr8Rwdk2B38Fb4q3zAe3+d2zxvWClvvaYAmCZ?=
 =?us-ascii?Q?Gl7+uWkyDhzW2u2KPS16Zyl0laBnsY7SvA5NUZ3l9W+qDzMHvb9g6CpPTpWM?=
 =?us-ascii?Q?IvtbegzbyGmuVtkihoM4zdEHeVN1A4An4sCdm/uFlNOyId8FABJ8DBs6P7um?=
 =?us-ascii?Q?iGmhMbwJtLMWJaQwVR5IgmJriLONh8PQmE0Rrai/NqEMuNtlqoxtt3f7yc+L?=
 =?us-ascii?Q?s3JeJWSnHCIlybpBJ6ywwF+6QVMeoUGUvA/U74I67kJEglmyq6CW/cXaGmmc?=
 =?us-ascii?Q?X5S3mKOHyGkVAjL3dCiEHrKYJCg3+E7QLZfV1a3ZJgwYPHq1dpih4jYkMi1k?=
 =?us-ascii?Q?s68l4UqD7Q3Kyj9512LZxfnOvSsFxurQ3TbWYIOj62NL5AqAPVCVw+BUZkG2?=
 =?us-ascii?Q?7nBPH7bLdj4+Hy7l15hkSz+YTJk2l1AThgLcJ76QrN22MTT5qjhi800NdvYm?=
 =?us-ascii?Q?fNJzKXt/mUScoXKBWMF5Y84=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MJ2K66Qhe03NImDsmFEueAmkdpAusWmiAG5vtAK3ZlZTdosQfVtQOBWPbRu6?=
 =?us-ascii?Q?BrpaqfO76tNUj3oD3jY8FBqIKq16QTAFTHb/OexZXGJG8BiqmJhDnQaSnPdc?=
 =?us-ascii?Q?WboxKQJ2Vlo3kFiWpeYDj00tenj7heFXpGBa1jwi6eBFoN6xRqTzFOVzUNMz?=
 =?us-ascii?Q?82W8EKr5r/hXeJLgmEMhsCNwQ1uZ8DZaDICbyemaL4t80coznob/SyEwk8sC?=
 =?us-ascii?Q?pF+D8EfkoiZ7PRqMdO2cJryWQgpGs+TOzEz63hGuSDlFNRrL+hp+T4YjeEIp?=
 =?us-ascii?Q?CmQr1tfFkkvh+dBZqc3t8P25SHFfjBNrIeYmjir9y/yeDZfqtKd0RZ5PTrww?=
 =?us-ascii?Q?skX677J+N4dBDVyycx/xoSuJlD79Uvdkmzdtzz80+2LiBtYCb/eO9CNYAiXO?=
 =?us-ascii?Q?7KYAbQymXSJ0nunRYDZHndXlg7obg4gAjDcaRxKVdagkgRg31CdwgFEy5dZE?=
 =?us-ascii?Q?wXx1IV36QCAYkP/3Aca9FjShkyjgBG6zistPuxVHiCPZWSYqxEmiwH2RpFiZ?=
 =?us-ascii?Q?sCHaPVZxcHT2uVkIhoX9G/EmdtZ8nTyNQ0RLZxTIujL4IPE61BF/wm5EZXYE?=
 =?us-ascii?Q?8bVLK7mafpUBqGWC8qyFTcl6kjICX8d/XeXOkuqNN2On5K5g9+2QVWxnEqhu?=
 =?us-ascii?Q?H5p2Iyn50n3i+tjhqXvB51yCEKNfdvHQECe6uwKKVGHJ0KjE21t4BWaCRq5G?=
 =?us-ascii?Q?mU0Y9zcwmlzX1/YlvDUWxr8gh7ZMbA/5VOqC9f73JEwzdFke7+ICVW01JOyn?=
 =?us-ascii?Q?vbp6r4YR/j8YkNathiznCinz4q+nzz7HIBiXkibPpVeCtzYOlIvK0DSXTVym?=
 =?us-ascii?Q?whm2LMbF6hmjmjEf9tLBuB4h8dEC/vpPBrvrcUiwAuCI/mtjKWxx7GJYUbCY?=
 =?us-ascii?Q?kUXtIO3NxHXLeo56i5+bY1XKz8c5rYrHWOYC5SSS2wUc4yhVDmLvlhI4KTpg?=
 =?us-ascii?Q?ClDcybJ5r8LZXQAg52m9jv/NeFI32UOt3MP6hr323Ar5DBnewfk12q5GTvPn?=
 =?us-ascii?Q?cu2AF+9THXLwAKMA5/YGDdOqR5qPOQwihbL6sZvCMrnHh/q9Ar78FxJgidAy?=
 =?us-ascii?Q?NOW8C0VcCll9vjOT8Qsjozh6IcR0ARAnKjSYPTp48flW0ouaB+0Ei990l5N1?=
 =?us-ascii?Q?UR4Zd4FtfKGHA/U5bOhLAL+zpbrZYS9Hprvu0HCAi7wGovNM4nu9ZlUvzjRK?=
 =?us-ascii?Q?oYTBMEs44M05gE9NUl0dcrsA+ABIRBRIXs7QyD6jpTinRJZ0gLJ29AsyqIIC?=
 =?us-ascii?Q?XLP9ht+o0gzoNP0GkmmmrxS6FLNqBMiVmKcFLS7D2fcyVw23E0OHEwMkSgCq?=
 =?us-ascii?Q?MGONh8a7mNymWEIIfaW7v6YUyN7sNYKApL23kypUA7txkWihxyQ4sjaW1/dQ?=
 =?us-ascii?Q?N/uHeF1JwChkLh849hjQ7gNchO6kfwJyDT3fyAd4jMWbBKHG1IPfkU8WOLTc?=
 =?us-ascii?Q?cVzP/JtvBHl3mAafi0TfQipr26HzuhLc4lAmK1A5P9tArlBQsYp1GAMVCbGt?=
 =?us-ascii?Q?fTaUn/Uee8gE2bmdAazslBlrKfbR3lhWSPDQgbUPsN2xj1mnoqms2GsPMcxF?=
 =?us-ascii?Q?x5tC3m09xYYAiD58F1q9nCz7q2mYrD0dArpn+tT0OFjcasMFNvkpZnQNM5No?=
 =?us-ascii?Q?xoZVQidSFT/rYYcvkS48sua/CdgLDqGddUh1Z1X3aHs/HnR6ogle3ffCs4Go?=
 =?us-ascii?Q?ikYU9K+2Hp5Vj6oH8f4yxoKxMlZuqwMAb21BJrynyluVtrRD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc98bce-cb7e-44d3-da86-08de5a8b5de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 14:26:15.5128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PssmUnbdasGD7imvAnk6kfOjWv0/Bf716v6UIA7BOlsVevYAmLzOe9k09YVdXt8cTsQL+moBVcn8vNHSZa4R3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8464-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 1ABEB77048
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, January 21, 2026 10:49 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.

--[ Snipped some headers to reduce the size of this mail ]--

> > > > >
> > > > > On Fri, Jan 09, 2026 at 05:33:54PM +0530, Devendra K Verma wrote:
> > > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mod=
e.
> > > > > > The current code does not have the mechanisms to enable the
> > > > > > DMA transactions using the non-LL mode. The following two
> > > > > > cases are added with this patch:
> > > > > > - For the AMD (Xilinx) only, when a valid physical base address=
 of
> > > > > >   the device side DDR is not configured, then the IP can still =
be
> > > > > >   used in non-LL mode. For all the channels DMA transactions
> > > > > > will
> > > > >
> > > > > If DDR have not configured, where DATA send to in device side by
> > > > > non-LL mode.
> > > > >
> > > >
> > > > The DDR base address in the VSEC capability is used for driving
> > > > the DMA transfers when used in the LL mode. The DDR is configured
> > > > and present all the time but the DMA PCIe driver uses this DDR
> > > > base address (physical address) to configure the LLP address.
> > > >
> > > > In the scenario, where this DDR base address in VSEC capability is
> > > > not configured then the current controller cannot be used as the
> > > > default mode supported is LL mode only. In order to make the
> > > > controller usable non-LL mode is being added which just needs SAR,
> > > > DAR, XFERLEN and control register to initiate the transfer. So,
> > > > the DDR is always present, but the DMA PCIe driver need to know
> > > > the DDR base physical address to make the transfer. This is useful
> > > > in scenarios where the memory
> > > allocated for LL can be used for DMA transactions as well.
> > >
> > > Do you means use DMA transfer LL's context?
> > >
> >
> > Yes, the device side memory reserved for the link list to store the
> > descriptors, accessed by the host via BAR_2 in this driver code.
> >
> > > >
> > > > > >   be using the non-LL mode only. This, the default non-LL mode,
> > > > > >   is not applicable for Synopsys IP with the current code addit=
ion.
> > > > > >
> > > > > > - If the default mode is LL-mode, for both AMD (Xilinx) and Syn=
osys,
> > > > > >   and if user wants to use non-LL mode then user can do so via
> > > > > >   configuring the peripheral_config param of dma_slave_config.
> > > > > >
> > > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > > ---
> > > > > > Changes in v8
> > > > > >   Cosmetic change related to comment and code.
> > > > > >
> > > > > > Changes in v7
> > > > > >   No change
> > > > > >
> > > > > > Changes in v6
> > > > > >   Gave definition to bits used for channel configuration.
> > > > > >   Removed the comment related to doorbell.
> > > > > >
> > > > > > Changes in v5
> > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > >   In the dw_edma_device_config() WARN_ON replaced with
> dev_err().
> > > > > >   Comments follow the 80-column guideline.
> > > > > >
> > > > > > Changes in v4
> > > > > >   No change
> > > > > >
> > > > > > Changes in v3
> > > > > >   No change
> > > > > >
> > > > > > Changes in v2
> > > > > >   Reverted the function return type to u64 for
> > > > > >   dw_edma_get_phys_addr().
> > > > > >
> > > > > > Changes in v1
> > > > > >   Changed the function return type for dw_edma_get_phys_addr().
> > > > > >   Corrected the typo raised in review.
> > > > > > ---
> > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 42
> > > +++++++++++++++++++++---
> > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46
> ++++++++++++++++++--
> > > ------
> > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > > > > ++++++++++++++++++++++++++++++++++-
> > > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > > > >
> > > > > edma-v0-core.c have not update, if don't support, at least need
> > > > > return failure at dw_edma_device_config() when backend is eDMA.
> > > > >
> > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > >  6 files changed, 132 insertions(+), 20 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > index b43255f..d37112b 100644
> > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > @@ -223,8 +223,32 @@ static int dw_edma_device_config(struct
> > > > > dma_chan *dchan,
> > > > > >                                struct dma_slave_config *config)=
  {
> > > > > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > > > > > +     int non_ll =3D 0;
> > > > > > +
> > > > > > +     if (config->peripheral_config &&
> > > > > > +         config->peripheral_size !=3D sizeof(int)) {
> > > > > > +             dev_err(dchan->device->dev,
> > > > > > +                     "config param peripheral size mismatch\n"=
);
> > > > > > +             return -EINVAL;
> > > > > > +     }
> > > > > >
> > > > > >       memcpy(&chan->config, config, sizeof(*config));
> > > > > > +
> > > > > > +     /*
> > > > > > +      * When there is no valid LLP base address available then=
 the
> default
> > > > > > +      * DMA ops will use the non-LL mode.
> > > > > > +      *
> > > > > > +      * Cases where LL mode is enabled and client wants to use=
 the
> non-LL
> > > > > > +      * mode then also client can do so via providing the
> peripheral_config
> > > > > > +      * param.
> > > > > > +      */
> > > > > > +     if (config->peripheral_config)
> > > > > > +             non_ll =3D *(int *)config->peripheral_config;
> > > > > > +
> > > > > > +     chan->non_ll =3D false;
> > > > > > +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll &&
> non_ll))
> > > > > > +             chan->non_ll =3D true;
> > > > > > +
> > > > > >       chan->configured =3D true;
> > > > > >
> > > > > >       return 0;
> > > > > > @@ -353,7 +377,7 @@ static void
> > > > > > dw_edma_device_issue_pending(struct
> > > > > dma_chan *dchan)
> > > > > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(xfer-
> >dchan);
> > > > > >       enum dma_transfer_direction dir =3D xfer->direction;
> > > > > >       struct scatterlist *sg =3D NULL;
> > > > > > -     struct dw_edma_chunk *chunk;
> > > > > > +     struct dw_edma_chunk *chunk =3D NULL;
> > > > > >       struct dw_edma_burst *burst;
> > > > > >       struct dw_edma_desc *desc;
> > > > > >       u64 src_addr, dst_addr;
> > > > > > @@ -419,9 +443,11 @@ static void
> > > > > > dw_edma_device_issue_pending(struct
> > > > > dma_chan *dchan)
> > > > > >       if (unlikely(!desc))
> > > > > >               goto err_alloc;
> > > > > >
> > > > > > -     chunk =3D dw_edma_alloc_chunk(desc);
> > > > > > -     if (unlikely(!chunk))
> > > > > > -             goto err_alloc;
> > > > > > +     if (!chan->non_ll) {
> > > > > > +             chunk =3D dw_edma_alloc_chunk(desc);
> > > > > > +             if (unlikely(!chunk))
> > > > > > +                     goto err_alloc;
> > > > > > +     }
> > > > >
> > > > > non_ll is the same as ll_max =3D 1. (or 2, there are link back en=
try).
> > > > >
> > > > > If you set ll_max =3D 1, needn't change this code.
> > > > >
> > > >
> > > > The ll_max is defined for the session till the driver is loaded in =
the
> kernel.
> > > > This code also enables the non-LL mode dynamically upon input from
> > > > the DMA client. In this scenario, touching ll_max would not be a
> > > > good idea as the ll_max controls the LL entries for all the DMA
> > > > channels not just for a single DMA transaction.
> > >
> > > You can use new variable, such as ll_avail.
> > >
> >
> > In order to separate out the execution paths a new meaningful variable
> "non_ll"
> > is used. The variable "non_ll" alone is sufficient. Using another
> > variable along side "non_ll" for the similar purpose may not have any
> added advantage.
>
> ll_avail can help debug/fine tune how much impact preformance by adjust l=
l
> length. And it make code logic clean and consistent. also ll_avail can he=
lp test
> corner case when ll item small. Normall case it is hard to reach ll_max.
>

Thank you for your suggestion. The ll_max is max limit on the descriptors t=
hat can
be accommodated on the device side DDR. The ll_avail will always be less th=
an ll_max.
The optimization being referred can be tried without even having to declare=
 the ll_avail
cause the number of descriptors given can be controlled by the DMA client b=
ased on the length
argument to the dmaengine_prep_* APIs. So, the use of dynamic ll_avail is n=
ot necessarily
required. Without increasing the ll_max, ll_avail cannot be increased. In o=
rder to increase
ll_max one may need to alter size and recompile this driver.

However, the requirement of ll_avail does not help for the supporting the n=
on-LL mode.
For non-LL mode to use:
1) Either LL mode shall be not available, as it can happen for the Xilinx I=
P.
2) User provides the preference for non-LL mode.
For both above, the function calls are different which can be differentiate=
d by using
the "non_ll" flag. So, even if I try to accommodate ll_avail, the call for =
LL or non-LL would be
ambiguous as in case of LL mode also we can have a single descriptor as sim=
ilar to non-LL mode.
Please check the function dw_hdma_v0_core_start() in this review where the =
decision is taken
Based on non_ll flag.

> >
> > > >
> > > > > >
> ...
> > > > > > +
> > > > > > + ll_block->bar);
> > > > >
> > > > > This change need do prepare patch, which only change
> > > > > pci_bus_address() to dw_edma_get_phys_addr().
> > > > >
> > > >
> > > > This is not clear.
> > >
> > > why not. only trivial add helper patch, which help reviewer
> > >
> >
> > I was not clear on the question you asked.
> > It does not look justified when a patch is raised alone just to replace=
 this
> function.
> > The function change is required cause the same code *can* support
> > different IPs from different vendors. And, with this single change
> > alone in the code the support for another IP is added. That's why it
> > is easier to get the reason for the change in the function name and syn=
tax.
>
> Add replace pci_bus_address() with dw_edma_get_phys_addr() to make
> review easily and get ack for such replacement patches.
>
> two patches
> patch1, just replace exist pci_bus_address() with dw_edma_get_phys_addr()
> patch2, add new logic in dw_edma_get_phys_addr() to support new vendor.
>

I understand your concern about making the review easier. However, given th=
at
we've been iterating on this patch series since September and are now at v9=
,
I believe the current approach is justified. The function renames from
pci_bus_address() to dw_edma_get_phys_addr() is directly tied to the
non-LL mode functionality being added - it's needed because the same code
now supports different IPs from different vendors.

Splitting this into a separate preparatory patch at this stage would furthe=
r
delay the review process. The change is kind of straightforward and the con=
text is clear
within the current patch. I request you to review this patch to avoid addit=
ional review cycles.

This also increases the work related to testing and maintaining multiple pa=
tches.
I have commitment for delivery of this, and I can see adding one more serie=
s definitely
add 3-4 months of review cycle from here. Please excuse me but this code ha=
s already
been reviewed extensively by other reviewers and almost by you as well. You=
 can check
the detailed discussion wrt this function at the following link:
https://lore.kernel.org/all/SA1PR12MB8120341DFFD56D90EAD70EDE9514A@SA1PR12M=
B8120.namprd12.prod.outlook.com/

> >
> > > >
> > > > > >               ll_region->paddr +=3D ll_block->off;
> > > > > >               ll_region->sz =3D ll_block->sz;
> > > > > >
> ...
> > > > > >
> > > > > > +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk
> > > > > *chunk)
> > > > > > +{
> > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > +     struct dw_edma *dw =3D chan->dw;
> > > > > > +     struct dw_edma_burst *child;
> > > > > > +     u32 val;
> > > > > > +
> > > > > > +     list_for_each_entry(child, &chunk->burst->list, list) {
> > > > >
> > > > > why need iterated list, it doesn't support ll. Need wait for irq
> > > > > to start next
> > > one.
> > > > >
> > > > > Frank
> > > >
> > > > Yes, this is true. The format is kept similar to LL mode.
> > >
> > > Just fill one. list_for_each_entry() cause confuse.
> > >
> > > Frank
> >
> > I see, we can use list_first_entry_or_null() which is dependent on
> > giving the type of pointer, compared to this list_for_each_entry()
> > looks neat and agnostic to the pointer type being used. Though, it can =
be
> explored further.
> > Also, when the chunk is allocated, the comment clearly spells out how
> > the allocation would be for the non LL mode so it is evident that each
> > chunk would have single entry and with that understanding it is clear
> > that loop will also be used in a similar manner, to retrieve a single
> > entry. It is a similar use case as of "do {}while (0)" albeit needs a c=
ontext to
> understand it.
>
> I don't think so. list_for_each_entry() is miss leading to reader think i=
t is not
> only to one item in burst list, and use polling method to to finish many =
burst
> transfer.
>
> list_for_each_entry() {
>         ...
>         readl_timeout()
> }
>
> Generally, EDMA is very quick, polling is much quicker than irq if data i=
s small.
>
> Frank
>

The polling is not required. The single burst will raise the interrupt and =
from the
interrupt context another chunk will be scheduled. This cycle repeats till =
all the chunks
with single burst are exhausted.

The following comment made in function dw_edma_device_transfer() in the sam=
e patch
makes it amply clear that only a single burst would be handled for the non-=
LL mode.
+       /*
+        * For non-LL mode, only a single burst can be handled
+        * in a single chunk unlike LL mode where multiple bursts
+        * can be configured in a single chunk.
+        */

Looking at the way bursts are appended to chunks and chunks in dw_edma_devi=
ce_transfer()
are scheduled for non-LL mode then it is clear what non-LL mode would handl=
e in terms of bursts.
I just kept the format to match it with the LL mode format otherwise there =
is no
need of this comment and we can follow the syntax for a single entry alone.
Please share your suggestion if these descriptions fail to provide the clea=
r context and intent.

> >
> > > >
> > > > >
> > > > > > +             SET_CH_32(dw, chan->dir, chan->id, ch_en,
> > > > > > + HDMA_V0_CH_EN);
> > > > > > +
> > > > > > +             /* Source address */
> > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > > > > > +                       lower_32_bits(child->sar));
> > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > > > > > +                       upper_32_bits(child->sar));
> > > > > > +
> > > > > > +             /* Destination address */
> > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > > > > > +                       lower_32_bits(child->dar));
> > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > > > > > +                       upper_32_bits(child->dar));
> > > > > > +
> > > > > > +             /* Transfer size */
> > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > + transfer_size,
> > > > > > + child->sz);
> > > > > > +
> > > > > > +             /* Interrupt setup */
> > > > > > +             val =3D GET_CH_32(dw, chan->dir, chan->id, int_se=
tup) |
> > > > > > +                             HDMA_V0_STOP_INT_MASK |
> > > > > > +                             HDMA_V0_ABORT_INT_MASK |
> > > > > > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > > > > > +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > > > +
> > > > > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > > > > > +                     val |=3D HDMA_V0_REMOTE_STOP_INT_EN |
> > > > > > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > > > > > +             }
> > > > > > +
> > > > > > +             SET_CH_32(dw, chan->dir, chan->id, int_setup,
> > > > > > + val);
> > > > > > +
> > > > > > +             /* Channel control setup */
> > > > > > +             val =3D GET_CH_32(dw, chan->dir, chan->id, contro=
l1);
> > > > > > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > > > > > +             SET_CH_32(dw, chan->dir, chan->id, control1,
> > > > > > + val);
> > > > > > +
> > > > > > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > > > > +                       HDMA_V0_DOORBELL_START);
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk
> > > > > > +*chunk, bool
> > > > > > +first) {
> > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > +
> > > > > > +     if (chan->non_ll)
> > > > > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > > > > +     else
> > > > > > +             dw_hdma_v0_core_ll_start(chunk, first); }
> > > > > > +
> > > > > >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan
> > > > > > *chan)
> > > {
> > > > > >       struct dw_edma *dw =3D chan->dw; diff --git
> > > > > > a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > index eab5fd7..7759ba9 100644
> > > > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > @@ -12,6 +12,7 @@
> > > > > >  #include <linux/dmaengine.h>
> > > > > >
> > > > > >  #define HDMA_V0_MAX_NR_CH                    8
> > > > > > +#define HDMA_V0_CH_EN                                BIT(0)
> > > > > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > > > > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > > > > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > b/include/linux/dma/edma.h index 3080747..78ce31b 100644
> > > > > > --- a/include/linux/dma/edma.h
> > > > > > +++ b/include/linux/dma/edma.h
> > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > >       enum dw_edma_map_format mf;
> > > > > >
> > > > > >       struct dw_edma          *dw;
> > > > > > +     bool                    non_ll;
> > > > > >  };
> > > > > >
> > > > > >  /* Export to the platform drivers */
> > > > > > --
> > > > > > 1.8.3.1
> > > > > >


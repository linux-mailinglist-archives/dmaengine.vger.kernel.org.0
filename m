Return-Path: <dmaengine+bounces-8393-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI1IHf5mcWmaGgAAu9opvQ
	(envelope-from <dmaengine+bounces-8393-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 00:53:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8E5FAD4
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 00:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3FB1824472
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024A3A89B5;
	Tue, 20 Jan 2026 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jCqoaPJn"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956D5343204;
	Tue, 20 Jan 2026 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909016; cv=fail; b=oOInBGPJOgfuh+l9SaPjeDzqGnbEWlwXSKVx7Uuk/TwWJ7qXUQzwZoFnQT4JdlMu6v89QSWBMKpfU7dnicUT2hqRZR6h1Si0W7PXwbZHh3WqbuoETMJ6xA6kcbH3F5GpLKjELjts7FcSnepSHO+QPBM7ATc7bq4E7+bWBdKZ+QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909016; c=relaxed/simple;
	bh=uM2m0LnEx5N1YqO/oaEZy2KkLVv/QRSqPekaWoUTHvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LI50r1TtLOzGwoOh+swRQIGldl2OBiYtHixhwcPQ/j01DvrLTd8VuGvMpU+ugEilEubF4CVDheDhFPZE3hZKZRaP3RzGGxiJQGP7gJr25blEhEvh6+u+7mb1XMTa0erTgdmW5By5+8rHvLB1XcpOgHLkfqufBnIPKOZiRmls96g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jCqoaPJn; arc=fail smtp.client-ip=40.93.196.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNTGGLaLO3t2qBqKnMIE2q+K0bOmO4qxK8bNCQDLde+NqAHL+HG3Ry1h9sGfVm5PUJ+Byj/nIfFSZESBNo5kHWY/ynwf0hw1EKPdvB5vRs9VxjajNIRwiDCcBtjOQs8aS7doH4v0G9l33z6Ne0pVezUFJ7IcfVHQMqLPmoReLReMVJskbJudxeMLunKipVUKqJPyFIjFfbHdcizxtiCdTzXjFpBGVevxre7vmpA2yMLyp9CPnGpf+hRhZ+nJiZHRqBIvBSC5qXScUWDS2GkOiucWI0AQYZrzNwNLF46EDDSyaSa9Tt4VIsx5ExwkEn4UUFCnIgcpsKiaRMcA9xXlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7I2uYwqE/dvmnd8VdMPsxEQD01GmZWQJCCzrMErNqA=;
 b=YXfCcUqE2jpiczG2Izs9lrXCWK3nbxqw+TqOXn9CQD12SDgVrsZqDEYYd8jVJdu3/uYyz52GwOchu51eUOMnsTow3dYwa6sqj3llUblOwaLRzBNQJMb+2AJekZTbO7JGARugLtNXjwuXEyvQon2bwCSjLJeMMgRM4y/yL/gIKnl5vdNz0d0bIriANClQxl7WCjxhRpsyzzG6pILbhBt7pJjMdELdLUQWEQi4/ctRAriMGwS3W/NWJNuB1fmE3Cxb+jLC31p+eygODFlfBPq3JZ5RKIKfOFZR0HXfytEJsKXg/cYLuFF44F/bpQYbc5YgXH1LR3Ykn0UmnOECWwKmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7I2uYwqE/dvmnd8VdMPsxEQD01GmZWQJCCzrMErNqA=;
 b=jCqoaPJnyL9JdmePB+dVGKAraAJHLiXGaCNVoGoxDlMKYOBN1m+afOU5y3QJv0WDmnLzcFHiycuDTFyKspjrWqS05is/ilq6hZswXRZ4hHGuWukGSQ1iEtXA7jXM1rfqw2oqgEKXSmWc92x4aHxv7QBE/2ZTFM44fzmI3dBZzqA=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 11:36:52 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 11:36:51 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Topic: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Index: AQHcgWARe54h1fxwa0KhQPOEEiCB/rVTczOAgAWkE2CAAJ8sAIABQA3g
Date: Tue, 20 Jan 2026 11:36:51 +0000
Message-ID:
 <SA1PR12MB8120D50A18E90DEACF2B2E419589A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-2-devendra.verma@amd.com>
 <aWkT/TDoLNnGUNlG@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E8E85ABE669FD626E75D9588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5U5AoUkE2uCzaL@lizhi-Precision-Tower-5810>
In-Reply-To: <aW5U5AoUkE2uCzaL@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T11:05:01.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|PH7PR12MB8108:EE_
x-ms-office365-filtering-correlation-id: 89d5b833-e487-4f1a-1f92-08de581834a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ivOIgZZTOWWR5JymEoEEpTdvDR07IccerflgGjYzU/ptT93OSaB4L1ynxEIY?=
 =?us-ascii?Q?5GziMqpe7askp+0PgsS7XitoR2FFtfJRb1+wpJzpjfm4a7O9FA6Msn2kgwYm?=
 =?us-ascii?Q?m6/05eEFJ4WHuDYobtqKHDGv/l7Ar5jKC07hzQOJeSfqRsGxhzsTL6adP0P7?=
 =?us-ascii?Q?nBV8ksqpizO/kUIrIcMsIYFYGnY5GFai+bKewiLmqeBVTSjj/W0+npwL3CLq?=
 =?us-ascii?Q?sUOJwS4XTFoCrCEskQczTMoVhF1HfugeW9yiHFyLn/Rwbzxhl9R1sOEgWlhB?=
 =?us-ascii?Q?gULywANnBU9wzlRqoIk4X6wOm70VkVHQTep6SKQu4EImX+kviJrphKFIdXLi?=
 =?us-ascii?Q?0dXOOmO2SVmxMpFNIo3aBI0An2SSI2B7Zsw2WVFIW4/BA5h7E4aQ2SiqBIWJ?=
 =?us-ascii?Q?7/VO6KBqXXxrjc4DEVNgmWZE1z38/EkbmscZnW5UosD4n/aF26c6sVUJ6AvQ?=
 =?us-ascii?Q?YtFceeXiWBeqqaWGyFx4BIIfKOZ/DbxBq6Dmb0QOHdef09UskEr68361mAdk?=
 =?us-ascii?Q?62Pv+2QGYSwX8WqVCg0v/eOhwhvi1LMTzO+5+mow4Wm4S263Z1qv54DmuAVj?=
 =?us-ascii?Q?hwYPGVEc++ZTOjK6eo61k1lNb7KOZMtzvEGh68tnRSnq/nHHXc5+o2qyWMdi?=
 =?us-ascii?Q?vsAB8+dJWMF73exr5twoSnsGEqRelOqUZFZLbk8nv/unG5ti75Dj5pdp2qmA?=
 =?us-ascii?Q?nipP5zXpPtu8y1FAiyjGHvDpGcsbCqDMeQtIhoEqJ0uB0fHrufV4HwJyKJix?=
 =?us-ascii?Q?5dg1E71UwCrmgysrRT4DLOSgTWDkEPUPOR1ab9fv0YIagyQxvAT1Dr1KYY1r?=
 =?us-ascii?Q?O63O7UBbibz39K1ZWQF0LFt5EvzWVv+GllfRtF+AhmIoeyK+fYVoava8E1Tv?=
 =?us-ascii?Q?vtU64En8LxWUu4ZazD9EaOt6POgB+cYY84RVSwmk+F5ClE6KkoAss7XCTOQg?=
 =?us-ascii?Q?gM7uyXgJzlMknIh31KUxL5L3CIh8igfoaswHGEuVOcY1gg+sm0kRyp46Wv00?=
 =?us-ascii?Q?T0yeK6dHZ22HKT4qpbY7FrWuz07sdlC0Eg+UxeV4YiqEozlsjPsPMkAF2sdx?=
 =?us-ascii?Q?anwNejjEavZY678Q0JZWDDc5fzbZvuXDuf7DINTUP4qEVBiU6SchjPNudvNg?=
 =?us-ascii?Q?prVMamLiTKOKMkpKjLpM3w9yULxhGesQlne/bIZPePqu8aB4uYCFMK5aI5R4?=
 =?us-ascii?Q?ZJBXIseY5ERKbPFqKS8qKriStw/dLTLtEh8AEv3ngPcUvaQ9GU6PPSFFCxFp?=
 =?us-ascii?Q?AbC6PcXvbm2GDBLF9CRqSmKGyj045SVjyfVeOHOZnB8S97sTAexDFT/6KvwA?=
 =?us-ascii?Q?CWYlq+4FedTFOPkAMn+kYgAqEPP93IRrV9ftyntWHs6hhfeEIrHLrYFk6vsL?=
 =?us-ascii?Q?4FIvHGFg2FbWk1jAkUJYmX9q9mnvlZiRVL9kppt2iHVeuAX+JJuLJVtqEMYg?=
 =?us-ascii?Q?Iq/JohXBfGQoxIAI0KixNrdKpjvW4rRRaiJvIY+QwvqqKmPft+X+mvtZId1S?=
 =?us-ascii?Q?a51BuCbcLBv/EDvHlVG2Eu4p97rFhpbSXv2LPu/H+FrMKw6hfO1pAeaB8NmJ?=
 =?us-ascii?Q?eBmNz0VzAVqGRnZzb7xd8/CGZzvnfvjWs1q7m+aNEhO8bXxb8POooZ9X9Tf3?=
 =?us-ascii?Q?JR+TzVnio9u8tj8w+L6hYo4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PjrkMK9tkBSAUqPJIvOmJE3l1yTSXq9hhU2nQFgBlH01TeIAj+rVNrKNY2qv?=
 =?us-ascii?Q?dU1TcRh3b9k1ocvlxdnIMh8tblaczV+8zWFpN69pyABnn5JH6wrXE8pFoTxU?=
 =?us-ascii?Q?vQx47gLnPNJHBtetQiePOP8bjD71bkvunhQ8U5yGlRSqjdNBQUQmshKuNdFu?=
 =?us-ascii?Q?U7cYDfVgi4el+kdLu7AyWjN5MBTr+LQgRkrXqk5vWzii6Yrmm+iBk5mQZ5fU?=
 =?us-ascii?Q?cU6WXbBVg6X1oZmdHd5tv4tb+pa6jf+IG6xtRiV3/2+pDNVgV7VkZNk1bUSv?=
 =?us-ascii?Q?lORaY0dpIA/vOKgywRQYcjiKLnJTkPhEHs6mXNuKBNnZajsXAd4KTOkWwMxP?=
 =?us-ascii?Q?zfJ0dTp9LVSU1ZdZ9hZSTtYbCIEdFkrZN0vBk+jQ6luTfJWYke5LY75mRAuL?=
 =?us-ascii?Q?X4MkPCsNpfhLsBy15LaZ6gBl4A9IRTy4U+iTFxPUIdydbw+7PSY8sFh3xhVM?=
 =?us-ascii?Q?YMvs+tU0bUdzuO1JUvNXdSTKQAXPbZaLNK/6peQA5n9mKODePeOkVx0B9SDr?=
 =?us-ascii?Q?lSmTM1BQX/4z+Tx+RXDzziEvm8lGMZL8ExOU/PUXZcD3GWaF3EjaDsL2KkY/?=
 =?us-ascii?Q?NC6qBiKrOMcq1ew6ngEzo1tAHv9kUd+LcACF03JK+8WGUKViCVYRaMID+DG1?=
 =?us-ascii?Q?oT2ys0nq82MKfsM1VDci08M7bylezMOyhMcUkRXcOudMj8taFdJR2Tf7a4tI?=
 =?us-ascii?Q?pX39SVTfrQ3e903L/Ax/k3R//LBRHyP9CpHErTfgoPmuIl0FchNa3HSrJ1OA?=
 =?us-ascii?Q?OnvrnObANlbvZMWDcmf0cuZ9X7p9206ZFKJrfzprMHEybdxW+cBH0xznzQ/j?=
 =?us-ascii?Q?6B+jXJ/sa7M8rOmv+4S64BkjM2ZWmKluYZlXZYo1biso1ijWtPK/hABgAz0p?=
 =?us-ascii?Q?5bf3IoTtjiaihUcjdFd3hx/3gUOMHgc7h7h8gmjzoow3v8Mw+Hc0DkryzMqn?=
 =?us-ascii?Q?8NLHK/297po9tFZ3hstCdNjfLNwcwThIju6zp44cJOX4BIGAu0uVWkfTnIYk?=
 =?us-ascii?Q?ur362OEmcY9XtST58KpQs5WerY1eShcEaoLdzk9GY6ej9FYK8zP+DSIegHwK?=
 =?us-ascii?Q?24I1ePyIjDc+cYYBnVIobY2j7j0DxlgiNsPJWXvbEOw6K9/bGIDi/tvbKidI?=
 =?us-ascii?Q?brwUOqS3SkVaw3oGCK0/QBOKzEns340e+oVJ5YXhcZdCBI9nVk0DOtkNBJVJ?=
 =?us-ascii?Q?g4o+lAKGqdWeJDLqu6YIObbzmWwhlc/bFvKTXAAvBSrzLrcBiFW8B0cldZsO?=
 =?us-ascii?Q?1NUXbZ8w3Gwa6X0gd0+xR19ntgataXMCtfkHHDonn962FteJG4H2C+IfZD0N?=
 =?us-ascii?Q?tZ858x8Fu8vB/27LmstLM4JHh/5mKYLesh7HWOtq+DY3bzjcQ0cxmWu4Y3kA?=
 =?us-ascii?Q?JeERVM3ENX3eXnGDRmUZFI8bihDDww+9NgqGDfapeqTrquRG3r1wlU/jYdNU?=
 =?us-ascii?Q?QrJ2odOis/CYFO8hcAIP2pw2m9Lo5+OGlU1GHKDcgjywrDQaf2PlM79+QcOo?=
 =?us-ascii?Q?PPhMfa5ytzmgCCJX/bvZYRcWUNP8vJuh5+snL4+4iFNPx0H9oqyRN8dBH/xx?=
 =?us-ascii?Q?93XLqFKdeAAtyVl8q2Jw2PrUatPpMcY+azYABJ1Uv2I8Hn/UO6QiCVqNbyFA?=
 =?us-ascii?Q?lnDfwwyd3nJ7ZihnGgPuKCpxZFnAmGUmzuyydmNY7t41g1AQ8n6UHXKExpbJ?=
 =?us-ascii?Q?fWEs8TxgtWpwiAX3ZLnBEQb7WdrLlTuFtRATmX4w0vF41VY1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d5b833-e487-4f1a-1f92-08de581834a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 11:36:51.8963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMf3WvMxCjO19kk4sUt7CimsVoxnXWykAGbKkYFnI4MyJTSo5COUpCURJQiZ2mOJPYYZxOkTFaj5Wm8AeFfHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DATE_IN_PAST(1.00)[36];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8393-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 6AA8E5FAD4
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Monday, January 19, 2026 9:30 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> Support
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Jan 19, 2026 at 09:09:11AM +0000, Verma, Devendra wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Frank
> >
> > Please check my comments inline.
> >
> > Regards,
> > Devendra
> >
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Thursday, January 15, 2026 9:51 PM
> > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB
> Endpoint
> > > Support
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Fri, Jan 09, 2026 at 05:33:53PM +0530, Devendra K Verma wrote:
> > > > AMD MDB PCIe endpoint support. For AMD specific support added the
> > > > following
> > > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > > >   - AMD MDB specific driver data
> > > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > > >     base address.
> > > >
> > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > ---
> > > > Changes in v8:
> > > > Changed the contant names to includer product vendor.
> > > > Moved the vendor specific code to vendor specific functions.
> > > >
> > > > Changes in v7:
> > > > Introduced vendor specific functions to retrieve the vsec data.
> > > >
> > > > Changes in v6:
> > > > Included "sizes.h" header and used the appropriate definitions
> > > > instead of constants.
> > > >
> > > > Changes in v5:
> > > > Added the definitions for Xilinx specific VSEC header id,
> > > > revision, and register offsets.
> > > > Corrected the error type when no physical offset found for device
> > > > side memory.
> > > > Corrected the order of variables.
> > > >
> > > > Changes in v4:
> > > > Configured 8 read and 8 write channels for Xilinx vendor Added
> > > > checks to validate vendor ID for vendor specific vsec id.
> > > > Added Xilinx specific vendor id for vsec specific to Xilinx Added
> > > > the LL and data region offsets, size as input params to function
> > > > dw_edma_set_chan_region_offset().
> > > > Moved the LL and data region offsets assignment to function for
> > > > Xilinx specific case.
> > > > Corrected comments.
> > > >
> > > > Changes in v3:
> > > > Corrected a typo when assigning AMD (Xilinx) vsec id macro and
> > > > condition check.
> > > >
> > > > Changes in v2:
> > > > Reverted the devmem_phys_off type to u64.
> > > > Renamed the function appropriately to suit the functionality for
> > > > setting the LL & data region offsets.
> > > >
> > > > Changes in v1:
> > > > Removed the pci device id from pci_ids.h file.
> > > > Added the vendor id macro as per the suggested method.
> > > > Changed the type of the newly added devmem_phys_off variable.
> > > > Added to logic to assign offsets for LL and data region blocks in
> > > > case more number of channels are enabled than given in
> amd_mdb_data struct.
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-pcie.c | 192
> > > > ++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 178 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > index 3371e0a7..2efd149 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > @@ -14,14 +14,35 @@
> > > >  #include <linux/pci-epf.h>
> > > >  #include <linux/msi.h>
> > > >  #include <linux/bitfield.h>
> > > > +#include <linux/sizes.h>
> > > >
> > > >  #include "dw-edma-core.h"
> > > >
> > > > -#define DW_PCIE_VSEC_DMA_ID                  0x6
> > > > -#define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> > > > -#define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> > > > -#define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> > > > -#define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 1=
6)
> > > > +/* Synopsys */
> > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID         0x6
> > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR                GENMASK(10,
> 8)
> > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP                GENMASK(2, 0)
> > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH              GENMASK(9,
> 0)
> > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH              GENMASK(25,
> 16)
> > >
> > > Sorry, jump into at v8.
> > > According to my understand 'DW' means 'Synopsys'.
> > >
> >
> > Yes, DW means Designware representing Synopsys here.
> > For the sake of clarity, a distinction was required to separate the
> > names of macros having the similar purpose for other IP, Xilinx in
> > this case. Otherwise, it is causing confusion which macros to use for
> > which vendor. This also helps in future if any of the vendors try to
> > retrieve a new or different VSEC IDs then all they need is to define ma=
cros
> which clearly show the association with the vendor, thus eliminating the
> confusion.
>
> If want to reuse the driver, driver owner take reponsiblity to find the
> difference.
>
> If define a whole set of register, the reader is hard to find real differ=
ence.
>

It is not regarding the register set rather VSEC capability which can diffe=
r
in the purpose even for the similar IPs. As is the current case where one
VSEC ID serves the similar purpose for both the IPs while the VSEC ID =3D 0=
x20
differs in meaning for Synopsys and Xilinx thus I think it is OK to define =
new
macros as long as they do not create confusion.

> >
> > > > +
> > > > +/* AMD MDB (Xilinx) specific defines */
> > > > +#define PCI_DEVICE_ID_XILINX_B054            0xb054
> > > > +
> > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> > > > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR              GENMASK(10,
> 8)
> > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP              GENMASK(2,
> 0)
> > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH    GENMASK(9, 0)
> > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH    GENMASK(25,
> 16)
> > >
> > > These defination is the same. Need redefine again
> > >
> >
> > It is the similar case as explained for the previous comment. Please ch=
eck.
> >
> > > > +
> > > > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH       0xc
> > > > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW        0x8
> > > > +#define DW_PCIE_XILINX_MDB_INVALID_ADDR              (~0ULL)
> > >
> > > I think XILINX_PCIE_MDB_DEVMEM_OFF_REG_HIGH
> > >
> > > > +
> > > > +#define DW_PCIE_XILINX_MDB_LL_OFF_GAP                0x200000
> > > > +#define DW_PCIE_XILINX_MDB_LL_SIZE           0x800
> > > > +#define DW_PCIE_XILINX_MDB_DT_OFF_GAP                0x100000
> > > > +#define DW_PCIE_XILINX_MDB_DT_SIZE           0x800
> > > >
> > > >  #define DW_BLOCK(a, b, c) \
> > > >       { \
> > > > @@ -50,6 +71,7 @@ struct dw_edma_pcie_data {
> > > >       u8                              irqs;
> > > >       u16                             wr_ch_cnt;
> > > >       u16                             rd_ch_cnt;
> > > > +     u64                             devmem_phys_off;
> > > >  };
> > > >
> > > >  static const struct dw_edma_pcie_data snps_edda_data =3D { @@ -90,=
6
> > > > +112,64 @@ struct dw_edma_pcie_data {
> > > >       .rd_ch_cnt                      =3D 2,
> > > >  };
> > > >
> > > > +static const struct dw_edma_pcie_data xilinx_mdb_data =3D {
> > > > +     /* MDB registers location */
> > > > +     .rg.bar                         =3D BAR_0,
> > > > +     .rg.off                         =3D SZ_4K,        /*  4 Kbyte=
s */
> > > > +     .rg.sz                          =3D SZ_8K,        /*  8 Kbyte=
s */
> > > > +
> > > > +     /* Other */
> > > > +     .mf                             =3D EDMA_MF_HDMA_NATIVE,
> > > > +     .irqs                           =3D 1,
> > > > +     .wr_ch_cnt                      =3D 8,
> > > > +     .rd_ch_cnt                      =3D 8,
> > > > +};
> > > > +
> > > > +static void dw_edma_set_chan_region_offset(struct
> > > > +dw_edma_pcie_data
> > > *pdata,
> > > > +                                        enum pci_barno bar, off_t =
start_off,
> > > > +                                        off_t ll_off_gap, size_t l=
l_size,
> > > > +                                        off_t dt_off_gap, size_t
> > > > +dt_size) {
> > > > +     u16 wr_ch =3D pdata->wr_ch_cnt;
> > > > +     u16 rd_ch =3D pdata->rd_ch_cnt;
> > > > +     off_t off;
> > > > +     u16 i;
> > > > +
> > > > +     off =3D start_off;
> > > > +
> > > > +     /* Write channel LL region */
> > > > +     for (i =3D 0; i < wr_ch; i++) {
> > > > +             pdata->ll_wr[i].bar =3D bar;
> > > > +             pdata->ll_wr[i].off =3D off;
> > > > +             pdata->ll_wr[i].sz =3D ll_size;
> > > > +             off +=3D ll_off_gap;
> > > > +     }
> > > > +
> > > > +     /* Read channel LL region */
> > > > +     for (i =3D 0; i < rd_ch; i++) {
> > > > +             pdata->ll_rd[i].bar =3D bar;
> > > > +             pdata->ll_rd[i].off =3D off;
> > > > +             pdata->ll_rd[i].sz =3D ll_size;
> > > > +             off +=3D ll_off_gap;
> > > > +     }
> > > > +
> > > > +     /* Write channel data region */
> > > > +     for (i =3D 0; i < wr_ch; i++) {
> > > > +             pdata->dt_wr[i].bar =3D bar;
> > > > +             pdata->dt_wr[i].off =3D off;
> > > > +             pdata->dt_wr[i].sz =3D dt_size;
> > > > +             off +=3D dt_off_gap;
> > > > +     }
> > > > +
> > > > +     /* Read channel data region */
> > > > +     for (i =3D 0; i < rd_ch; i++) {
> > > > +             pdata->dt_rd[i].bar =3D bar;
> > > > +             pdata->dt_rd[i].off =3D off;
> > > > +             pdata->dt_rd[i].sz =3D dt_size;
> > > > +             off +=3D dt_off_gap;
> > > > +     }
> > > > +}
> > > > +
> > > >  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned
> > > > int
> > > > nr)  {
> > > >       return pci_irq_vector(to_pci_dev(dev), nr); @@ -114,15
> > > > +194,15 @@ static u64 dw_edma_pcie_address(struct device *dev,
> > > > phys_addr_t
> > > cpu_addr)
> > > >       .pci_address =3D dw_edma_pcie_address,  };
> > > >
> > > > -static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > > > -                                        struct dw_edma_pcie_data *=
pdata)
> > > > +static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev
> *pdev,
> > > > +                                            struct
> > > > +dw_edma_pcie_data
> > > > +*pdata)
> > > >  {
> > > >       u32 val, map;
> > > >       u16 vsec;
> > > >       u64 off;
> > > >
> > > >       vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSY=
S,
> > > > -                                     DW_PCIE_VSEC_DMA_ID);
> > > > +
> > > > + DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
> > > >       if (!vsec)
> > > >               return;
> > > >
> > > > @@ -131,9 +211,9 @@ static void
> > > dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > > >           PCI_VNDR_HEADER_LEN(val) !=3D 0x18)
> > > >               return;
> > > >
> > > > -     pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capabil=
ity
> > > DMA\n");
> > > > +     pci_dbg(pdev, "Detected Synopsys PCIe Vendor-Specific
> > > > + Extended Capability DMA\n");
> > > >       pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > > -     map =3D FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
> > > > +     map =3D FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_MAP, val);
> > > >       if (map !=3D EDMA_MF_EDMA_LEGACY &&
> > > >           map !=3D EDMA_MF_EDMA_UNROLL &&
> > > >           map !=3D EDMA_MF_HDMA_COMPAT && @@ -141,13 +221,13 @@
> > > static
> > > > void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > > >               return;
> > > >
> > > >       pdata->mf =3D map;
> > > > -     pdata->rg.bar =3D FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
> > > > +     pdata->rg.bar =3D FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_BAR,
> > > > + val);
> > > >
> > > >       pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > >       pdata->wr_ch_cnt =3D min_t(u16, pdata->wr_ch_cnt,
> > > > -                              FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, va=
l));
> > > > +
> > > > + FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));
> > > >       pdata->rd_ch_cnt =3D min_t(u16, pdata->rd_ch_cnt,
> > > > -                              FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, va=
l));
> > > > +
> > > > + FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH, val));
> > >
> > > If you don't change macro name, these change is not necessary. If
> > > really need change macro name, make change macro name as sperated
> patch.
> > >
> >
> > As explained above, the name change is required to avoid confusion.
> > The trigger to have the separate names for each IP is the inclusion of
> > Xilinx IP that is why no separate patch is created.
>
> Separate patch renmae macro only. Reviewer can simple bypass this typo
> trivial patch.
>
> Then add new one.
>
> Actually, Needn't rename at all.  You can directly use XLINNK_PCIE_*
>
> Frank

Please check the discussion on previous versions of the same patch series.
We have this patch as the outcome of those discussions.
Other reviewing members felt it that keeping the name similar for the
VSEC ID having similar purpose for two different IPs was causing the confus=
ion
that is why it was agreed upon the separate out the naming as per the
vendor-name of VSEC ID. Regarding the separate patch, the reason is introdu=
ction
of the new IP which mostly supports the similar functionality except in cas=
e of VSEC IDs
that's why the name separation became part of these patches. It sets the co=
ntext for
changing the name of the existing macros.

> >
> > > >
> > > >       pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > >       off =3D val;
> > > > @@ -157,6 +237,67 @@ static void
> > > dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > > >       pdata->rg.off =3D off;
> > > >  }
> > > >
> > > > +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > +                                          struct
> > > > +dw_edma_pcie_data
> > > > +*pdata) {
> > > > +     u32 val, map;
> > > > +     u16 vsec;
> > > > +     u64 off;
> > > > +
> > > > +     pdata->devmem_phys_off =3D
> DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > > > +
> > > > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > +                                     DW_PCIE_XILINX_MDB_VSEC_DMA_I=
D);
> > > > +     if (!vsec)
> > > > +             return;
> > > > +
> > > > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > > > +     if (PCI_VNDR_HEADER_REV(val) !=3D 0x00 ||
> > > > +         PCI_VNDR_HEADER_LEN(val) !=3D 0x18)
> > > > +             return;
> > > > +
> > > > +     pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended
> > > > + Capability
> > > DMA\n");
> > > > +     pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > > +     map =3D FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > > > +     if (map !=3D EDMA_MF_EDMA_LEGACY &&
> > > > +         map !=3D EDMA_MF_EDMA_UNROLL &&
> > > > +         map !=3D EDMA_MF_HDMA_COMPAT &&
> > > > +         map !=3D EDMA_MF_HDMA_NATIVE)
> > > > +             return;
> > > > +
> > > > +     pdata->mf =3D map;
> > > > +     pdata->rg.bar =3D
> FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR,
> > > val);
> > > > +
> > > > +     pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > +     pdata->wr_ch_cnt =3D min_t(u16, pdata->wr_ch_cnt,
> > > > +
> > > > + FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH,
> > > val));
> > > > +     pdata->rd_ch_cnt =3D min_t(u16, pdata->rd_ch_cnt,
> > > > +
> > > > + FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> > > > +
> > > > +     pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > > +     off =3D val;
> > > > +     pci_read_config_dword(pdev, vsec + 0x10, &val);
> > > > +     off <<=3D 32;
> > > > +     off |=3D val;
> > > > +     pdata->rg.off =3D off;
> > > > +
> > > > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
> > > > +     if (!vsec)
> > > > +             return;
> > > > +
> > > > +     pci_read_config_dword(pdev,
> > > > +                           vsec +
> DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> > > > +                           &val);
> > > > +     off =3D val;
> > > > +     pci_read_config_dword(pdev,
> > > > +                           vsec +
> DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> > > > +                           &val);
> > > > +     off <<=3D 32;
> > > > +     off |=3D val;
> > > > +     pdata->devmem_phys_off =3D off; }
> > > > +
> > > >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > >                             const struct pci_device_id *pid)  { @@
> > > > -184,7 +325,28 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> > > >        * Tries to find if exists a PCIe Vendor-Specific Extended Ca=
pability
> > > >        * for the DMA, if one exists, then reconfigures it.
> > > >        */
> > > > -     dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> > > > +     dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> > > > +     dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> > > > +
> > > > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> > >
> > > dw_edma_pcie_get_xilinx_dma_data() should be here.
> > >
> > > Frank
> >
> > Yes, this is good suggestion. Thanks!
> >
> > > > +             /*
> > > > +              * There is no valid address found for the LL memory
> > > > +              * space on the device side.
> > > > +              */
> > > > +             if (vsec_data->devmem_phys_off =3D=3D
> > > DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             /*
> > > > +              * Configure the channel LL and data blocks if number=
 of
> > > > +              * channels enabled in VSEC capability are more than =
the
> > > > +              * channels configured in xilinx_mdb_data.
> > > > +              */
> > > > +             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > > +                                            DW_PCIE_XILINX_MDB_LL_=
OFF_GAP,
> > > > +                                            DW_PCIE_XILINX_MDB_LL_=
SIZE,
> > > > +                                            DW_PCIE_XILINX_MDB_DT_=
OFF_GAP,
> > > > +                                            DW_PCIE_XILINX_MDB_DT_=
SIZE);
> > > > +     }
> > > >
> > > >       /* Mapping PCI BAR regions */
> > > >       mask =3D BIT(vsec_data->rg.bar); @@ -367,6 +529,8 @@ static
> > > > void dw_edma_pcie_remove(struct pci_dev
> > > > *pdev)
> > > >
> > > >  static const struct pci_device_id dw_edma_pcie_id_table[] =3D {
> > > >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > > > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > > > +       (kernel_ulong_t)&xilinx_mdb_data },
> > > >       { }
> > > >  };
> > > >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > > > --
> > > > 1.8.3.1
> > > >


Return-Path: <dmaengine+bounces-9358-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPnsH+0fsGmCgAIAu9opvQ
	(envelope-from <dmaengine+bounces-9358-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 14:43:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C91250A72
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 14:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4283133F4159
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66D3CF03A;
	Tue, 10 Mar 2026 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fgZEykD8"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B383CF050;
	Tue, 10 Mar 2026 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145862; cv=fail; b=sze4fvgs0PDwZiHrCDO1EtQcc4bPbSTSmJB5uJqW6PnYc/YJ94fC6XnQ+5xDpY55zHJaVbryK8fkviBa3uuKQOUtbDaNvJpf8+bjPd/3kOSMWcuqivj5I1oy3YAIPAZe7+Yqj2ywfADzkUJS9Z9Miz4urFl5ufYlJcjxgavW6NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145862; c=relaxed/simple;
	bh=d0PE1e2Z49q6p+qOKDKFCcYBIOm0LpThxYG5OFLOHac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ji0G8BIdtKmqx86itruNeJ8Vn5xHNvHWANIf8w0YoSjltiKPlqyeeg+vrPoiG8IhzT2+qrkSIMgv3spYBdBdvySADniAjlxIuvO2Nqi5gyAy9KIb2YYiPDyPYlYa8U0B0yYs+PbsOl3hR4zYVrM9vs6ds+99crF8QjwHe/CjUJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fgZEykD8; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOwa5j9BiHQ6jH3r6dN7u5EvuzZOTTZpcwsLa2sq6gySh2ILT/92fIF/54ojyK84ZqLAOWJjs2BwNMvdt/uG9CL0xk2QMb1ZW6Mf3PWe2d92o6NxO+JT10sHhPGC9K0PYlmW5cPsD8sZ8dKnO1XQzeMVG6XWWh+iGX/N8Qpb1R9aWajUj4vQ9A72UZTB6gaVj08cplqgtP0USmWp3e2TZu8e8Jod4oOdA3lvKetJUff9GcypfJKaZLzUOHYy6Br8qPf2Qz6D5/e3gX8wwVWJOJrFhll7ded9AkqXeTxnP3rIYChC96VONL0y4ijBDf9R0pXJx+iqSb2+0FrZ0TEp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSy/je96Bd72axdECgfldm7lHeS6k4LRCSc3xAFiax8=;
 b=hBEb/+iNgNmn22dUBp4FS7Pggz8cJjrcoFF6Dt0KFR95mH7HbkjITr5bV5x+7e1eptas7ZdDCsqKbhjQ9FP9P5I3V436nF6EKyka9f1JuZbuIShGZQjoYeC1HrEwPNLuaoZRvOHS19qDd5dE7JGJqTTWDcRgShSP2VFdRel/kUI7tdRDuqOWYVOfPvxBA7HB3jdDuiv3EYMwPjyoXw/2fbk2s6U9nk+SEAkRDvdqjCckJYKAb1nCyI530bdI+8DVghofDViVOgNPlKJYD6fGdz/gZ5G89Hb+EDm54QmGOcl3Ce4MiuI1tPLpvXcbTRkKjclUavjxjLsAL2+Wj9+zMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSy/je96Bd72axdECgfldm7lHeS6k4LRCSc3xAFiax8=;
 b=fgZEykD8F+Cp4wg+HG80BKG9SV7uiWq0d1rp3CnkCyfyFb063V4f0acYijturEwATPoI1lDSN7VwjuTKsH3C2fbC5l/2gvamBwiAJ43dA6drjxgM0jUm3j+mJB5lUNOB5fEM+5l5Gqi8MrLzpKhEPMtbjC3UW+s3Zdyf2f6GwTc=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Tue, 10 Mar
 2026 12:30:55 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 12:30:54 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcrV+81oF37YcXsEuF2ca3rlBfa7WiAmsAgAPv1kCAAGkcgIABQ5bg
Date: Tue, 10 Mar 2026 12:30:54 +0000
Message-ID:
 <SA1PR12MB8120763AADB50A31A54DD7899546A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260306115228.3446528-1-devendra.verma@amd.com>
 <20260306115228.3446528-3-devendra.verma@amd.com>
 <aatEUuynXVVYEhWy@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120969E61FCC5C46F1C1B739579A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aa7p7V7Dt_NbaOV8@lizhi-Precision-Tower-5810>
In-Reply-To: <aa7p7V7Dt_NbaOV8@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-10T10:58:38.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|LV8PR12MB9406:EE_
x-ms-office365-filtering-correlation-id: 4e8b0b67-9256-4f12-b74f-08de7ea0dfd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|22082099002|38070700021;
x-microsoft-antispam-message-info:
 Qm761tItYeLYXelnWDc5bqK/kXSwKk0Ntb6L1p+1ZrgjN3yhTw39cg76XJgihwZ+Pm07WlkQD6Q96d0uDONVGFFQC/6cxCsARzQ4DUCzCM6aIn14Ci4HOChf0KR53ZbeE8amsqiii7DEkuHVhs7XZ80VroJ1825sv2tZIsB7Y7+wcaY7FIsuXmvxeVupowiKPXG8Prq7ji2/6J8DTtqcFHgXz44hkOe45sIwca4dhFaGAN+BVxMgDclUQZopPQjgLnhOmLvE2kqGckPFZnUaGb4GFzS4BwarN9UZy8lQiw817LQBlBz49BrfAdhfYPeXXwzqoGdTLWs5fkViZP4uNKSPArCyo2N1+ReKr4w9nKAGkRUCkniyZPXomcLb6SVZnBBcGneOIIIB6PDzm9GByjYgOa4T1Efz83PqZD7B5hbb67K6I6zEZR5Fv9AEpBNGgemDvMIwovd4CSGoFO8RoaxMLlj+2DX1aUJjvqAWsOm+tBUlTFC7b5cct/jqULs6cgTS2mhKMcYmzQR5a4TaAGMef4/Wydrjvq+PrDIfXpnQLPrdKdowDRhXd6Spprr2HA0cbe6sB7tlgqMZ9MYiuVEQr55PNS5EPkmiyIzuZ8hv6NTh1eszZME1WtbTKAqb5yV/K3P7e7mVogq7MqSjNf1cNvWzJFAFnh86KnizOqfi/1bC3/G2utVR26gMIB5ucihNahPcD2ulDULhM+fSJDfcwHApwEG9s4mUS2ovyxeCDrTJkkTzX+p41LvJRioE4rB73uLZTEIyxH/kTHgGoBBKWuC6WIHMJD+ztp8J8Ck=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099002)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5E95/WG/+A3dNzsKWhlkfeQEXw7wzx6X1AFpVgoNHeRB1r0JURPKSXyRdkZW?=
 =?us-ascii?Q?mABAguMti3JED/T2LDKXkhgBtp5QC2evOtO5Hr7b9wPRSZUGYswCVyDHt26v?=
 =?us-ascii?Q?Mk3rQ5XNd8gfvZPtEoEmGjSO8UTN2UQgbw7+1dCLdAKZ1z69fzMI2RRFx04/?=
 =?us-ascii?Q?82OdY6BUzX/3ib4svf67ajC4+nRsunv7Wh/SYjPa/PfEoorLt4NCeoU+a/+y?=
 =?us-ascii?Q?VPidED2kfiCXTCP2Vu/uGPStNrxP44mve/VH4lyL2wuPpyXI9HnTtwwKEUn4?=
 =?us-ascii?Q?luyyCuZF/hWNNxapZx5QPszBzzVF0GSd+kOz589aFt/saCAPuTbiru5SoTH/?=
 =?us-ascii?Q?pHZ/vWQnk1hcNC2ggkIBRjfkI/TA0uRgdn1g9K1rXxd3yPxSUipwQqMcQ5sv?=
 =?us-ascii?Q?XcWBwtaPLp7OnyntfIJxHSO6DvnD0R8k4R4kIFRxLXBz/3qswsO/IUulG8pS?=
 =?us-ascii?Q?JguAXXnslRbAG1iC6upv3fZ/yOc1RoatYBbpMr1lzj4dQDFrX7uoNnkdwJr1?=
 =?us-ascii?Q?aLP6zKcHPbiH3rsx4c873M5OBohmKw41GcZeYf5O0IfzPjLGJcBzDgRyTuhs?=
 =?us-ascii?Q?9XdKWaVKfaNzxoCjXbjNx/BO0UeJDldK/sCAwNZekBGqhiyh7c/AWsc+Pie8?=
 =?us-ascii?Q?Y28BKZAkIiqgZFUoh3UGEWymFT5Xpq2sbvoAB60k2MEoMT8Ko2Z0Z1S9STIS?=
 =?us-ascii?Q?xVH8sqYUYg9N1Ks9xFztboquAHe2ScxZnXu+o/mXSBY/jScbmBbXM95Q4idl?=
 =?us-ascii?Q?+aXVNk87evKpMSAr7HJS+W07FEtdTTily0UFSZLkIdT+ekrVaZKRxQQIPwZn?=
 =?us-ascii?Q?wUortkxsnOSCB87AUUquJ+fDBscZJ690p1U3LbasxrB7/FEkv+6s/PUfATnG?=
 =?us-ascii?Q?tO3x8FWuXz2kN3/DgpY3sDOyZUmIseo9iOBvBvi56j1ee+r517k4E/n8hTFK?=
 =?us-ascii?Q?+kcYHi3MGFAkaQJrOxK0OmoeAOGz347WuxGlrOut76YUeQ8GHBpActX6II4F?=
 =?us-ascii?Q?JGvL/pdVYWmx+U32LKKIYMK4O+vWwbwSkdN9c9fQUtxkl7sGKWRLgHyPRoll?=
 =?us-ascii?Q?ZtVVGAKoUWf8+8TW1ghTxgqtPPbQFbom90sl+HHBxeuR5rw5A8TYoJ06dWai?=
 =?us-ascii?Q?cDs1Nu/wC2FGvXoD7LxAK8ibEwtnLeSJQ18+LWdKQ4Kf8cmv2okkydIbGsUV?=
 =?us-ascii?Q?7f+aI8p0dqWiXRgilxAXHtSHp1KTmbTseXGMoiTo20lWgc8BrGm0GBHvnSRN?=
 =?us-ascii?Q?Le24ouw7GwswgZb3YZDwCB3T+mczhncuSqFY0v4yrqsMYNxZI/fTUCEP2ISr?=
 =?us-ascii?Q?0mnL+0asg/WNm8v5qg7S9RlFjEThdm/AkUyvIbTG9H6m8n+QERB7ZEvaC029?=
 =?us-ascii?Q?wRnNPeZe/4zHvxhv8b5QhWqIH27lQ4DrTxRcA0ERb0yBPYvjes3kJbN24FPm?=
 =?us-ascii?Q?5CeggeIDNRKAlASShPWcNTzx4y5pxYoeQzX+HGq3ovUmNJu8sGEljcZ81hcR?=
 =?us-ascii?Q?MDUWkS1/v3tYe27b8SpviuXYnhiYYnzXfxoKbDcLZaJQkNNJFe2JNWGB/C0h?=
 =?us-ascii?Q?HpGlRDy5bk5wYnI3dxxMz6OJ+wh/MDRVkwCsbYUg/xpRtvP9lKF9W564dhXl?=
 =?us-ascii?Q?0d+RZrvJzKc9by+40278MyedCc6ia4wsbD/VPbEBqHQhCip3qJjZx0n/g/XH?=
 =?us-ascii?Q?QzXLMZ+GI3IgYTWJCpIb10+IEfvt/t00SEiUy603FDVsOyZk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8b0b67-9256-4f12-b74f-08de7ea0dfd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 12:30:54.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozeOjJKg8peGsINrH+G9hG8zL0FDKIUOwvur8ezBbG5nY8POqiItak5olynxdJPVkLzC679petjWFJ6S73ebFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
X-Rspamd-Queue-Id: C3C91250A72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9358-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,amd.com:dkim,amd.com:email]
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Monday, March 9, 2026 9:10 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Mar 09, 2026 at 11:18:33AM +0000, Verma, Devendra wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Saturday, March 7, 2026 2:47 AM
> > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > Subject: Re: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Fri, Mar 06, 2026 at 05:22:28PM +0530, Devendra K Verma wrote:
> > > ...
> > > > +             /*
> > > > +              * When there is no valid LLP base address available =
then the
> > > > +              * default DMA ops will use the non-LL mode.
> > > > +              *
> > > > +              * Cases where LL mode is enabled and client wants to=
 use the
> > > > +              * non-LL mode then also client can do so via providi=
ng the
> > > > +              * peripheral_config param.
> > > > +              */
> > > > +             cfg_non_ll =3D chan->dw->chip->cfg_non_ll;
> > > > +             if (config->peripheral_config) {
> > > > +                     non_ll =3D *(int *)config->peripheral_config;
> > > > +
> > > > +                     if (cfg_non_ll && !non_ll) {
> > > > +                             dev_err(dchan->device->dev, "invalid
> configuration\n");
> > > > +                             return -EINVAL;
> > > > +                     }
> > > > +             }
> > > > +
> > > > +             if (cfg_non_ll || (!cfg_non_ll && non_ll))
> > > > +                     chan->non_ll =3D true;
> > >
> > > this logic have a little bit complex
> > >
> > > if (cfg_non_ll)
> > >         chan->non_ll =3D true;
> > > else
> > >         chan->non_ll =3D non_ll;
> > >
> >
> > Thank you for your suggestion.
> > I think it is individual preference. I am not sure what seem to be
> > complex in the logic floated for review as all the boolean operations
> > are easy to comprehend in a single statement.
> > I am sure there are multiple ways to write the same logic.
> > To me, the logic you suggested looks bigger with the same outcome
> delivered.
> > If after distinction in variable names and simple boolean ops still
> > cause confusion then I am not sure till what point it can be simplified=
.
> > If fewer lines of code can deliver the same result, then it should be o=
k to
> keep it.
> > I would request to keep the change of the floated review.
>
> Reader need thank more about "cfg_non_ll || (!cfg_non_ll && non_ll)" to
> make sure it is correct and what it do, need create true table in brain.
>
> It is not enough straight forwards.
>

Hi Frank
I respectfully disagree with your assessment of the conditional statement.
Your suggestion is not acceptable for the following reasons:
 - Unnecessarily expands the logic to 'else' condition
- end-result is unpredictable
- as a side effect increases the number of lines of code, if this to be don=
e for every logic
   Including multiple statements when the "if()" clause can accept multiple=
 boolean statements.

Nevethless, I am going to simplify the logic further; the above statement c=
an be written as following:
If (cfg_non_ll || non_ll)
   chan->non_ll =3D true;

This way it is short and concise statement to follow, without any 'else' cl=
ause.
As I said, there could be multiple ways to write a logic.
The above logic is acceptable and represents the both the logics, proposed,=
 and floated one.
And, it is straight forward too!

I will float the next version of the patch series, please provide your appr=
oval. Thanks!

> Frank
>
> > Thanks!
> >
> > >
> > > > +     } else if (config->peripheral_config) {
> > > > +             dev_err(dchan->device->dev,
> > > > +                     "peripheral config param applicable only for =
HDMA\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > >
> > > ...
> > > >
> > > >  struct dw_edma_irq {
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > index b8208186a250..f538d728609f 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > @@ -295,6 +295,15 @@ static void
> > > dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > >       pdata->devmem_phys_off =3D off;  }
> > > >
> > > > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > > +                              struct dw_edma_pcie_data *pdata,
> > > > +                              enum pci_barno bar) {
> > > > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > > > +             return pdata->devmem_phys_off;
> > > > +     return pci_bus_address(pdev, bar); }
> > > > +
> > >
> > > Reduce each patches's changes, make each patch is straightforward
> > >
> > > Create Prepare patch firstly, change pci_bus_address() to
> > > dw_edma_get_phys_addr()
> > >
> > > just
> > >
> > > dw_edma_get_phys_addr() {
> > > {
> > >         return return pci_bus_address(pdev, bar); }
> > >
> > > So this patch just add
> > > two lines here
> > >
> > > if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > >         return pdata->devmem_phys_off;
> > >
> > >
> > > others look good.
> > >
> > > Frank
> > >
> >
> > Regarding this we already had discussion and it was concluded to let
> > this piece of code to be as is. Please check the discussion at the foll=
owing
> link:
> > https://lore.kernel.org/all/aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-581
> > 0/
> >
> > > >


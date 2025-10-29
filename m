Return-Path: <dmaengine+bounces-7030-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91367C193A3
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 09:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05F5E5000F7
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00352314D36;
	Wed, 29 Oct 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rD4gB1SG"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F92D7D2F;
	Wed, 29 Oct 2025 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726916; cv=fail; b=qYkl+UYl0JfPOEsYi/BJrK0wvv3Fcg7ZaZwn3/SnLaLatajXUQEBhOaNCFsFf5+JecU5X1nxfbEE1jXG/7kY1hxhziSl11BKwULUF2m6s4pFS1+v9AT1zoa4mGkJmYg37Cf5unCLgPESSWf2A95ipefpQa4MYp7a6Sj30q2zxMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726916; c=relaxed/simple;
	bh=oIRY6lLphpPCC6KCkyPKb5sW6w8RLRj+WsvEwpPGVsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVUgGTBTy+CgQaqU9ily/fFP9IB0EB7YXWNXcJFXWeEsw3lrQAdrQeL4pRgW7p0OkWwJsQbj2XMLnSI/lXBxgiWJxJ2aU4IibOIodB3UxSehX1IalGPiX2s1faZJeKKOMOcS2Vh5hYb8bDR2tBjdXKtNpriswz73MYwbYqd9ns4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rD4gB1SG; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWFsgr/Qto1Nkr7vTIPswzVKu7gbMDGdnyQqaR/ZMJdhdLnaYKVkvzfdAALdfuPDZvy2S3Xy+ioZk7Av4YeLPN/CmBU2OXeKm0PvQQcOJlKuPlEgRBFJccjWn7FU+a8nQu6GuyBpvxIIRvo/heQlZH3iPM7EZwNt1BKj9/LxPj+MYHNv1yrC/WABBtmc0bv6Q/EXKCkhpa9M7Bxd0Xvv/UoRiAKN/czxsvRKsrHZKkpTKWkPGkSUnRZagF7fcpzzXu4qFc79dOdn2iIYN5/t0cgQaRHs8sPDp8ox3+YN/CvFHhngbNe5p7c/ZeyYKxsGqtgqB4XOR45XMgd87C3doA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujXpmtsiuBe4/nvm+gAIuGWkcUa0jWjFhviWMmoJIoU=;
 b=ttMIxCB/VLaOTW8WZnlxe7CQb+1wx7v2upPPT1VpdEddj9IB1c1iDq/k2AYCc6eeBE5VPlw08sqSsE6VP5llG4IPSuB4Fp4syF03y4GEjrqPYAEwNZefk8c6OrHywFnsy4NbbTHwHHtlryfYDdzGgYzYltawka6Y7iYhyDDwGrbSuKVeS+wEkdVd+uXTsa/V5Y+7ewm2H1CGW9bG751wnEaq2ElyLguM4Pv4Gv5BjSeuguYNKq5FuhBwp01ahF/BUNC6K2nj3N+KMWAiJggsvw+2x4fq4aJyI2IBS58T3Ns7Wsw8Rw8/ciYGg+qpAQu+bS3OzoikyRG95Q/N5h9RhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujXpmtsiuBe4/nvm+gAIuGWkcUa0jWjFhviWMmoJIoU=;
 b=rD4gB1SGlqAwSljEs+UqutVf1gKXyC1caOItn/9no48g/DYm3xfowb8xDQxj+UwNfYsppyDhNbV6OqImjErdXwvJ20ukvpvcajtChX5geErChL2i18BxypzosBapVX4lyJBZV4CGsc08m9NMUczOI0uDS9Ui0iosOqJZJefXx/0=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by DS7PR12MB9525.namprd12.prod.outlook.com (2603:10b6:8:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:35:12 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 08:35:12 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v5 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v5 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcR/4YVHjn2k4agk+1X9PX4p5lEbTXjqQAgAE+V2A=
Date: Wed, 29 Oct 2025 08:35:12 +0000
Message-ID:
 <SA1PR12MB81204151B77CA7048E0D793595FAA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20251028112858.9930-1-devendra.verma@amd.com>
 <20251028112858.9930-3-devendra.verma@amd.com>
 <c5f6bdd8-417a-c360-eb62-c7e9409caf7f@linux.intel.com>
In-Reply-To: <c5f6bdd8-417a-c360-eb62-c7e9409caf7f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: ilpo.jarvinen@linux.intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-29T08:31:55.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|DS7PR12MB9525:EE_
x-ms-office365-filtering-correlation-id: 117f3a5f-1569-428f-068a-08de16c61393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5ThZCGgRBwzALQMikLfqM12+Txt5nIKBrznQqAlQbdjG+yeXd99B/58E2P?=
 =?iso-8859-1?Q?zUEzVUPeBnXt5NRtzYfTndUbai0Jbiojca0Hp69HblQ9bZhtZ713eNG1q1?=
 =?iso-8859-1?Q?GpxK1mpGKoNlhRwlapEOhUaFAm/wllhbz90/zbZb6tjcQpUEvXbcNXoVQm?=
 =?iso-8859-1?Q?IFsDF/lLCOL31U8HtCDYxROiwMDZPAwQzvmDwJdrEK33CTpEu2YmIAMHlV?=
 =?iso-8859-1?Q?/SmmA8QRX39jjwWC9WoRnfuNDEZArD4twXxsi2K0xQ3IU+rtCTKzw9NADS?=
 =?iso-8859-1?Q?lRf//LkphjgnDvrE9QrR6V5ml9o/QkAt2zCmTaw1npkt+7vJC96Djjf7Bd?=
 =?iso-8859-1?Q?MCzPZLea+kU/Qjp/t0AY2r4VPmcb+3Ie0moGFH4RBEgXeR2sna+8d9LYxe?=
 =?iso-8859-1?Q?PwRLHALDzC8p/mdQxGCqkEdwdobRk6o8JPhc/WgnSIf4j9BSMEnPJW7Df5?=
 =?iso-8859-1?Q?G1ZBDSZ4PVMzOkVcy4yprR/hP03N/vf2X2HlKbWSeJnmxh/5P46tA3lcXU?=
 =?iso-8859-1?Q?iv/Qr0JfE5e85TsbSURyDf5VycbQckrZ3ppiL0jktiBFXkLpvCjTF4dFwK?=
 =?iso-8859-1?Q?h4QouzUeJN2X+Gt1XcnJPhimK6KK0yf312qKQDgn9zcRBaeGQ7RenM6P4B?=
 =?iso-8859-1?Q?/2gT7CKMdWnxd+0EBtNxk+1rttBkOAhDO+ePVlQ5Yg8JlzrVhq0GnOVOaD?=
 =?iso-8859-1?Q?rBZxF/JRH2OW4GE1WwbargVIo8SQnttcypxfvkD+17nnDLgfuqshe+vsk4?=
 =?iso-8859-1?Q?0WZ+zoHJa1AHTVTMnJQspAXVtYbikK4J/YYaNQqgwIf93+yWNFshmhl7jv?=
 =?iso-8859-1?Q?F9Or5BME7UXuWcKVJxq0H/c0rRE6v6BtlbieQwP5et+3TfFBQFTbwtP5yf?=
 =?iso-8859-1?Q?YegWrV+vMJRBKiljeJAvP2vKAnnbg8mmxelkguCRj/D70EGpjC3blmAn8d?=
 =?iso-8859-1?Q?v2phm6IMRl5Gcy2g4z0B0p0YPhl3kKij3NPU7Quw8649YAVlJ26zig3IBD?=
 =?iso-8859-1?Q?8qnHlqiNsmzvGVS2MNtTK1RqrP4VsNOaGRS8dLosIgQHOUEtmLgV7YG7jr?=
 =?iso-8859-1?Q?i9Y88JjykLD00tu2ie31t8rcA00f+FcN3zZOiVFSed4N137JAoc6xl7hvk?=
 =?iso-8859-1?Q?ZCiASFXGeIB1dJOWAT8cG08sGAwlq1vGUPdRqHMRFlgMtAyOCuUJxptFBr?=
 =?iso-8859-1?Q?3CvGWoFQUU0wcLlF3pw0w34s+O7rLh5P8tVDKsjo97eQA+HcK1ahcI3yrf?=
 =?iso-8859-1?Q?+rIQ4/UvGWMY4gv0FaC3QyiA6xo7vGb3ob93TJrYYXhEi5uUYIc8oUc6Tq?=
 =?iso-8859-1?Q?Mzk4HW19dFEvNwnzj6UDjOxrN1f6O4T+Wkc4nt5CVce+oxHd7cdtltRsaN?=
 =?iso-8859-1?Q?lLvLs0D2aFatkehtfAp+n1KRV1Y0srP0/1cKk36f/cHsUTCN6owVXRmym4?=
 =?iso-8859-1?Q?rLdPkUcdz3yRjuKC35iveUF8CYYfAOa8JE2DvzJGlhnvwX76SFSJuy+xa/?=
 =?iso-8859-1?Q?w0eQXCQLgPsoHgTpVYUDImkIbIQe9Hx9nYmeUsEyFqwz+WGDjX5Gjcmtct?=
 =?iso-8859-1?Q?qeb1gd94ikOq3CvzxDgOpI/C3sg1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3fX7JMFoi3gqaSNF390mOAwg23tmTP/fMb7GdVc5ityLBv50K+NXR+jWsN?=
 =?iso-8859-1?Q?2AJ8PVc8hfno5Qjs6tRGDwm6Fn41Rw6VZSgKKR5Vl1V83LlZ9Uw4WQjP+E?=
 =?iso-8859-1?Q?l4uwrECO8V61QVsdNKryQ2Uy3FiwD25uRnZY3yr9CtJKjts2fOKpVC/19W?=
 =?iso-8859-1?Q?13Cnc3VPY2kFXT5+jn+XVX0/QCFY65BSGewOcW7p5khGc8vaH8THkzzCpW?=
 =?iso-8859-1?Q?RQfMisy59GM3fsG7lWVi6m8msofRNx86PYPdcIn2DZ6v4jWKEZY9Q9JkV0?=
 =?iso-8859-1?Q?v4xms96yjeBiu3xXX66J4RH9wO+lRlHPJBckg3cdgkroaHtPe0yXHvIYSV?=
 =?iso-8859-1?Q?J1seF29RFVPZfrkNV6ZWfwqVBZl2XQ+bsLGyeSsjJdrs0YkMfeUHw1QPT4?=
 =?iso-8859-1?Q?4YnMIZE/VBdsFPO8isqlBnjhK3y5DrsbBhPDWCrHvr724iiXS1aKu9wgcK?=
 =?iso-8859-1?Q?YLabODpEmGV65gVJGapZveNFKZjFoxC9kg9qIjafRVoI8i0x9OaWBR6ZK1?=
 =?iso-8859-1?Q?CG9fJsa2V3hQPuAwkup2aCpXkT72ohUd+rj+qtPr/0UtubJPSOt8ttUNaR?=
 =?iso-8859-1?Q?FZrDqUAIPdS0IkrmUugHTXSTVh8cQocb/VPko2Ap4owI32lxIZ/DAXRYZy?=
 =?iso-8859-1?Q?chEm4AKzlfSx7WnPCa7XMcfsh98sT2lb8N/vKQvtHO/iy5ucSIZaT6fRrc?=
 =?iso-8859-1?Q?ETVjRmpLVDZbvKCHq4Mx8L85FgpM/xoKH+/rB8EIg+j6LHsXpClgQfKOC5?=
 =?iso-8859-1?Q?lZ5mUShG835ib6c5YxTIwDo03nFFaJAitw6phX7D+HXN3WokA3QSn99hCx?=
 =?iso-8859-1?Q?hDfjRwBXPmtqud9ezWbOqMN4iZoKKWTOz8Yd/AH5PLftSgumqYFT/yJfNP?=
 =?iso-8859-1?Q?Wq/uQa9aCu6FffBQ+RQT/BFZF28olKCA5w4RAEWzs9GtHVYiEPHW1DNGvb?=
 =?iso-8859-1?Q?pmx6tR5hGkwHnfIz2wapAO58lRpwfh29PSaAfvdB0KMFskSZ/kEfd0Iswf?=
 =?iso-8859-1?Q?xZrBKIGRTm72xeV8OzZsn9gJITjGZIsWpDKLegWYspcUh6c2SjnojC3sOy?=
 =?iso-8859-1?Q?Lih3jBY0Z/m/gz5q2cDrDlDURp/EZ/8Oj23cczYGgfQnxcvecp13XyR+Q2?=
 =?iso-8859-1?Q?sEIG7UxDxoCwnX0AVlYRCDlfyZey+mxZW4df4r95ef2Ir3YfpZAjmPE6Aq?=
 =?iso-8859-1?Q?7Iq1xYR6APVr9l00beTsan+KPZgV5/Qnl3FYyjZJhEx2xra2FMdu0unnr4?=
 =?iso-8859-1?Q?cRlwlWbp/9SK7ZpWYF3eHsTE0dljvqaCztCpfAkakXY5tssZ7eYRQMC5BK?=
 =?iso-8859-1?Q?CZ2HYpYBb5awj0XGR/32OMfRkiuDw8aF6ZeFhB87Vq4ppW2E2JsYtVeGGS?=
 =?iso-8859-1?Q?XTFY++t8SWjH/N03gYcPVY9ct033FF0ZzNxZxC5IqC6xMRHM6d35UnHDWy?=
 =?iso-8859-1?Q?qP+Fap4hDjj3eREovvYLlI38A+6VA2jIsOSSKxgmPWGzyl1Og6P068DXm+?=
 =?iso-8859-1?Q?8DqG6UMC6lcvuc/ucYc816KbtYM7WVAadfTVrs5V87jibKya2Oky++Ro3f?=
 =?iso-8859-1?Q?m2YCBa84d+95GzAM7QyOn21mo05DobQ30Iz8ZCZ8lf5ye5wDzpS1yddrtY?=
 =?iso-8859-1?Q?5DW0ExXWR12+g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 117f3a5f-1569-428f-068a-08de16c61393
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 08:35:12.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ne/xD+ySe8YKn1MAKZIhiL2WF5UgW+Neen/KYkW0lOuzQlp7x9q2d6TQRAqyoy6uIEd0NGoEUlkBgKxS7SVN1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9525

[AMD Official Use Only - AMD Internal Distribution Only]

Thank you @Ilpo J=E4rvinen for the inputs.
Please check my response inline.

Regards,
Devendra

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Tuesday, October 28, 2025 7:03 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; LKML <linux-
> kernel@vger.kernel.org>; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v5 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Tue, 28 Oct 2025, Devendra K Verma wrote:
>
> > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > The current code does not have the mechanisms to enable the DMA
> > transactions using the non-LL mode. The following two cases are added
> > with this patch:
> > - When a valid physical base address is not configured via the
> >   Xilinx VSEC capability then the IP can still be used in non-LL
> >   mode. The default mode for all the DMA transactions and for all
> >   the DMA channels then is non-LL mode.
> > - When a valid physical base address is configured but the client
> >   wants to use the non-LL mode for DMA transactions then also the
> >   flexibility is provided via the peripheral_config struct member of
> >   dma_slave_config. In this case the channels can be individually
> >   configured in non-LL mode. This use case is desirable for single
> >   DMA transfer of a chunk, this saves the effort of preparing the
> >   Link List. This particular scenario is applicable to AMD as well
> >   as Synopsys IP.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> > Changes in v5
> >   Variable name 'nollp' changed to 'non_ll'.
> >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> >   Comments follow the 80-column guideline.
> >
> > Changes in v4
> >   No change
> >
> > Changes in v3
> >   No change
> >
> > Changes in v2
> >   Reverted the function return type to u64 for
> >   dw_edma_get_phys_addr().
> >
> > Changes in v1
> >   Changed the function return type for dw_edma_get_phys_addr().
> >   Corrected the typo raised in review.
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 41 ++++++++++++++++++++---
> >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 62
> ++++++++++++++++++++++++++++++++++-
> >  include/linux/dma/edma.h              |  1 +
> >  5 files changed, 130 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > b/drivers/dma/dw-edma/dw-edma-core.c
> > index b43255f..60a3279 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct
> dma_chan *dchan,
> >                                struct dma_slave_config *config)  {
> >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > +     int non_ll =3D 0;
> > +
> > +     if (config->peripheral_config &&
> > +         config->peripheral_size !=3D sizeof(int)) {
> > +             dev_err(dchan->device->dev,
> > +                     "config param peripheral size mismatch\n");
> > +             return -EINVAL;
> > +     }
> >
> >       memcpy(&chan->config, config, sizeof(*config));
> > +
> > +     /*
> > +      * When there is no valid LLP base address available then the def=
ault
> > +      * DMA ops will use the non-LL mode.
> > +      * Cases where LL mode is enabled and client wants to use the non=
-LL
> > +      * mode then also client can do so via providing the peripheral_c=
onfig
> > +      * param.
> > +      */
> > +     if (config->peripheral_config)
> > +             non_ll =3D *(int *)config->peripheral_config;
> > +
> > +     chan->non_ll =3D false;
> > +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll)=
)
> > +             chan->non_ll =3D true;
> > +
> >       chan->configured =3D true;
> >
> >       return 0;
> > @@ -353,7 +376,7 @@ static void dw_edma_device_issue_pending(struct
> dma_chan *dchan)
> >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(xfer->dchan);
> >       enum dma_transfer_direction dir =3D xfer->direction;
> >       struct scatterlist *sg =3D NULL;
> > -     struct dw_edma_chunk *chunk;
> > +     struct dw_edma_chunk *chunk =3D NULL;
> >       struct dw_edma_burst *burst;
> >       struct dw_edma_desc *desc;
> >       u64 src_addr, dst_addr;
> > @@ -419,9 +442,11 @@ static void dw_edma_device_issue_pending(struct
> dma_chan *dchan)
> >       if (unlikely(!desc))
> >               goto err_alloc;
> >
> > -     chunk =3D dw_edma_alloc_chunk(desc);
> > -     if (unlikely(!chunk))
> > -             goto err_alloc;
> > +     if (!chan->non_ll) {
> > +             chunk =3D dw_edma_alloc_chunk(desc);
> > +             if (unlikely(!chunk))
> > +                     goto err_alloc;
> > +     }
> >
> >       if (xfer->type =3D=3D EDMA_XFER_INTERLEAVED) {
> >               src_addr =3D xfer->xfer.il->src_start; @@ -450,7 +475,13
> > @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
> >               if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
> >                       break;
> >
> > -             if (chunk->bursts_alloc =3D=3D chan->ll_max) {
> > +             /*
> > +              * For non-LL mode, only a single burst can be handled
> > +              * in a single chunk unlike LL mode where multiple bursts
> > +              * can be configured in a single chunk.
> > +              */
> > +             if ((chunk && chunk->bursts_alloc =3D=3D chan->ll_max) ||
> > +                 chan->non_ll) {
> >                       chunk =3D dw_edma_alloc_chunk(desc);
> >                       if (unlikely(!chunk))
> >                               goto err_alloc; diff --git
> > a/drivers/dma/dw-edma/dw-edma-core.h
> > b/drivers/dma/dw-edma/dw-edma-core.h
> > index 71894b9..c8e3d19 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -86,6 +86,7 @@ struct dw_edma_chan {
> >       u8                              configured;
> >
> >       struct dma_slave_config         config;
> > +     bool                            non_ll;
> >  };
> >
> >  struct dw_edma_irq {
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 7b991a0..b02977c 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -268,6 +268,15 @@ static void
> dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> >       pdata->devmem_phys_off =3D off;
> >  }
> >
> > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > +                              struct dw_edma_pcie_data *pdata,
> > +                              enum pci_barno bar) {
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > +             return pdata->devmem_phys_off;
> > +     return pci_bus_address(pdev, bar); }
> > +
> >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                             const struct pci_device_id *pid)  { @@
> > -277,6 +286,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       struct dw_edma_chip *chip;
> >       int err, nr_irqs;
> >       int i, mask;
> > +     bool non_ll =3D false;
> >
> >       vsec_data =3D kmalloc(sizeof(*vsec_data), GFP_KERNEL);
> >       if (!vsec_data)
> > @@ -301,21 +311,24 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> >               /*
> >                * There is no valid address found for the LL memory
> > -              * space on the device side.
> > +              * space on the device side. In the absence of LL base
> > +              * address use the non-LL mode or simple mode supported b=
y
> > +              * the HDMA IP.
> >                */
> >               if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_AMD_MDB_INVALID_ADDR)
> > -                     return -ENOMEM;
> > +                     non_ll =3D true;
> >
> >               /*
> >                * Configure the channel LL and data blocks if number of
> >                * channels enabled in VSEC capability are more than the
> >                * channels configured in amd_mdb_data.
> >                */
> > -             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > -                                            DW_PCIE_XILINX_LL_OFF_GAP,
> > -                                            DW_PCIE_XILINX_LL_SIZE,
> > -                                            DW_PCIE_XILINX_DT_OFF_GAP,
> > -                                            DW_PCIE_XILINX_DT_SIZE);
> > +             if (!non_ll)
> > +                     dw_edma_set_chan_region_offset(vsec_data, BAR_2, =
0,
> > +                                                    DW_PCIE_XILINX_LL_=
OFF_GAP,
> > +                                                    DW_PCIE_XILINX_LL_=
SIZE,
> > +                                                    DW_PCIE_XILINX_DT_=
OFF_GAP,
> > +
> > + DW_PCIE_XILINX_DT_SIZE);
> >       }
> >
> >       /* Mapping PCI BAR regions */
> > @@ -363,6 +376,7 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >       chip->mf =3D vsec_data->mf;
> >       chip->nr_irqs =3D nr_irqs;
> >       chip->ops =3D &dw_edma_pcie_plat_ops;
> > +     chip->non_ll =3D non_ll;
> >
> >       chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
> >       chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt; @@ -371,7 +385,7 @@
> > static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       if (!chip->reg_base)
> >               return -ENOMEM;
> >
> > -     for (i =3D 0; i < chip->ll_wr_cnt; i++) {
> > +     for (i =3D 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> >               struct dw_edma_region *ll_region =3D &chip->ll_region_wr[=
i];
> >               struct dw_edma_region *dt_region =3D &chip->dt_region_wr[=
i];
> >               struct dw_edma_block *ll_block =3D &vsec_data->ll_wr[i];
> > @@ -382,7 +396,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               ll_region->vaddr.io +=3D ll_block->off;
> > -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->bar)=
;
> > +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      ll_block->bar);
> >               ll_region->paddr +=3D ll_block->off;
> >               ll_region->sz =3D ll_block->sz;
> >
> > @@ -391,12 +406,13 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               dt_region->vaddr.io +=3D dt_block->off;
> > -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->bar)=
;
> > +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      dt_block->bar);
> >               dt_region->paddr +=3D dt_block->off;
> >               dt_region->sz =3D dt_block->sz;
> >       }
> >
> > -     for (i =3D 0; i < chip->ll_rd_cnt; i++) {
> > +     for (i =3D 0; i < chip->ll_rd_cnt && !non_ll; i++) {
> >               struct dw_edma_region *ll_region =3D &chip->ll_region_rd[=
i];
> >               struct dw_edma_region *dt_region =3D &chip->dt_region_rd[=
i];
> >               struct dw_edma_block *ll_block =3D &vsec_data->ll_rd[i];
> > @@ -407,7 +423,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               ll_region->vaddr.io +=3D ll_block->off;
> > -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->bar)=
;
> > +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      ll_block->bar);
> >               ll_region->paddr +=3D ll_block->off;
> >               ll_region->sz =3D ll_block->sz;
> >
> > @@ -416,7 +433,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               dt_region->vaddr.io +=3D dt_block->off;
> > -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->bar)=
;
> > +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      dt_block->bar);
> >               dt_region->paddr +=3D dt_block->off;
> >               dt_region->sz =3D dt_block->sz;
> >       }
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index e3f8db4..47ecc84 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct
> dw_edma_chunk *chunk)
> >               readl(chunk->ll_region.vaddr.io);  }
> >
> > -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > first)
> > +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk,
> > +bool first)
> >  {
> >       struct dw_edma_chan *chan =3D chunk->chan;
> >       struct dw_edma *dw =3D chan->dw;
> > @@ -263,6 +263,66 @@ static void dw_hdma_v0_core_start(struct
> dw_edma_chunk *chunk, bool first)
> >       SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > HDMA_V0_DOORBELL_START);  }
> >
> > +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk
> *chunk)
> > +{
> > +     struct dw_edma_chan *chan =3D chunk->chan;
> > +     struct dw_edma *dw =3D chan->dw;
> > +     struct dw_edma_burst *child;
> > +     u32 val;
> > +
> > +     list_for_each_entry(child, &chunk->burst->list, list) {
> > +             SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
>
> Please name BIT(0) with a define.
>

Sure, defined a macro HDMA_V0_CH_EN for clarity.

> > +
> > +             /* Source address */
> > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > +                       lower_32_bits(child->sar));
> > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > +                       upper_32_bits(child->sar));
> > +
> > +             /* Destination address */
> > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > +                       lower_32_bits(child->dar));
> > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > +                       upper_32_bits(child->dar));
> > +
> > +             /* Transfer size */
> > +             SET_CH_32(dw, chan->dir, chan->id, transfer_size,
> > + child->sz);
> > +
> > +             /* Interrupt setup */
> > +             val =3D GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > +                             HDMA_V0_STOP_INT_MASK |
> > +                             HDMA_V0_ABORT_INT_MASK |
> > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> > +
> > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > +                     val |=3D HDMA_V0_REMOTE_STOP_INT_EN |
> > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > +             }
> > +
> > +             SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> > +
> > +             /* Channel control setup */
> > +             val =3D GET_CH_32(dw, chan->dir, chan->id, control1);
> > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > +             SET_CH_32(dw, chan->dir, chan->id, control1, val);
> > +
> > +             /* Ring the doorbell */
> > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > +                       HDMA_V0_DOORBELL_START);
>
> Doesn't the code explain itself already, why you need to have that commen=
t
> above it, it doesn't seem to add any real value?
>

I followed the existing comment pattern and applied the same here.
I will remove this comment as pointed out it is self-explanatory.

> > +     }
> > +}
> > +
> > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > +first) {
> > +     struct dw_edma_chan *chan =3D chunk->chan;
> > +
> > +     if (!chan->non_ll)
> > +             dw_hdma_v0_core_ll_start(chunk, first);
> > +     else
> > +             dw_hdma_v0_core_non_ll_start(chunk);
> > +}
> > +
> >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)  {
> >       struct dw_edma *dw =3D chan->dw;
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> > 3080747..78ce31b 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> >       enum dw_edma_map_format mf;
> >
> >       struct dw_edma          *dw;
> > +     bool                    non_ll;
> >  };
> >
> >  /* Export to the platform drivers */
> >
>
> --
>  i.



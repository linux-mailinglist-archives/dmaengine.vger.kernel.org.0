Return-Path: <dmaengine+bounces-8971-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFZnJDHelmlJpgIAu9opvQ
	(envelope-from <dmaengine+bounces-8971-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 10:56:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCBF15D91A
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 10:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC69301AF47
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22CC30BBB0;
	Thu, 19 Feb 2026 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R2lTSGXG"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2344EEBB;
	Thu, 19 Feb 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494958; cv=fail; b=NgdgwpsPPa1wIURl0FmKT9b65g+X9jqIbf5rbiq34YjQ03XXOTCIWpfMyLcK+VjLaTuc9fEy2aDWtVvVaDCr5hCxP4DjDZVi/WhNNQp5O6EAbjaj4FumRWJs3WqBwH0iLWF3fw4HQMlqu2ur/Iwq4FwLgWSEOl/mnU7gAOQndCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494958; c=relaxed/simple;
	bh=XGNwWHFXAXWSeClP98rXipW0nkYE6RndwXTmWqc7K4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xm6YEVidLITkm93jyevBpRd3hqQjeFC9hKmAtpVsHQPF5QAcVXp76fZ+QwDHJMtjY3xj1KNgnBD3vd0m4Dna0JTHnj5IdRt8OgCV8GVNNhKx+Ml0/dxRVerrBQvQosrXodUIBISipLpUbased3RtvygYbJ7CUPy9csitU8UJY8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R2lTSGXG; arc=fail smtp.client-ip=40.93.194.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leCN0VvBe7iW1UsSbRwRgFHrV+rK3gUjARULwHpEuGAntllslsfAp5HesF4hEyKoA/bI4pbNvaknwkAlZfGhRFtsKBgnoMId/BHgl4boJvjkC7t+HAXkcigVvgnuDRG3WOc8AWeIugVVWazJpTBeU55cMU1n5stRyjLv45C/B7/06gUmJLodglFYfddbTKKr+1efmYnLahTOlUBzkmQ27FiH/2vdgyzBgGmKTp2AFbSWZoiThuwL2CdoZKsH8wa4xosVVo64FZlLVjfQtofJtHX2/ENJ8FV+UY81IUPINf6U8cv4om/GYyd69DOwj0xNhY2KndTZrzylETAG/rZq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0hI3ovtbgEppR0rEXNems1H1b6hnksXXtZ5hBKaidw=;
 b=aUkjNRgHLXi2t1VAFHUw971iNz3DytRnbI1qr7GilwScZDyLIpykSo1TF9Uolmumy5w+8Kyf9im+q9hl5Ha54pU45hkOmjc/9p4KJfDOxLkyRaI6h3h7b3RDKdqzg+Q9Buo+tBrlYyh1gkKKOe5AhiieJ1sAGzUWHVnMUKeNmKy54jScTd/9BfOdIZvl/iaartygp/Nxfu5ObSRJOC2CzcBoNynfHJPlK4M0xs0JQYG8xzf0Q4u583LvPDq7rLDnTzPQT96HySX8FEwkaC1WO5iNWNx0QEWdiUBlwkTy992uZLeBcsDrAIvWtqBnjZ6rLJyesiqU+n+v/XQkojdwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0hI3ovtbgEppR0rEXNems1H1b6hnksXXtZ5hBKaidw=;
 b=R2lTSGXGbthagpQ41LcOpo0ujdwGwZG8CEG9lWtO6OkyjxEgyAxHBGIfkr6OBjn+qddGWju3LH5hS2V/wPjMQvHfj87pCCXphVP3UIEpilpSR3iaJOlXlkMSvpQjlvT6rX1IveqJ0o4fg6SHZPPGkuMPL+GrGoyblc7J9ho8qjw=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 09:55:51 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 09:55:49 +0000
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
 AQHcnzLWCO8+PlOBsUyeigW/SoG/H7WFuzkAgACmYXCAALfggIABEsjwgABxvwCAAOnmsA==
Date: Thu, 19 Feb 2026 09:55:49 +0000
Message-ID:
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
 <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
In-Reply-To: <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-19T05:46:53.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|PH8PR12MB7134:EE_
x-ms-office365-filtering-correlation-id: f4238133-c83f-499d-392b-08de6f9d0fa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6Uz7mP+cqhBEJoVPDIt7ahoy7Ka+Atn79IVOH2odHcFBPn6f8al2Ov5hmCy9?=
 =?us-ascii?Q?TUg7H5IMMaamSebyRwKHKShjkpGA23UInHMQ9fRA7/Lxbd8jhzNxaqnGg9za?=
 =?us-ascii?Q?+9GZTrygkMBazdCQva9hdc8jeRiXfQZ1k0HMGPm08HmLfdW/X7j2H5IwNgZ4?=
 =?us-ascii?Q?aWOQW+qMKQAEhb1H2qQCEAfBpMgSBCae8+wtNd4VnE7AVNp9hpvk5aK3y0h3?=
 =?us-ascii?Q?i42R785WTSnEh6PpfJioFZacD5PDelBOWgtrV5OuiCeB/vXZ36OdKEDrWmb7?=
 =?us-ascii?Q?nhFH1jrYfr263BMk0omAsfop0BONiRgeHcf+FEf/nh0R1JzXPaGRemT8jr0J?=
 =?us-ascii?Q?VdGVNwm6KBAYdBIwgNCS/ngsRaLa7lVPmW5AQQspNp/pZ63eH6z4JmieemNK?=
 =?us-ascii?Q?ZQuT6h1olTPXQDDezKux+fbaIjq/96Mt5yrGxnTAQKnZCYS2Ary6q6f59nxO?=
 =?us-ascii?Q?8E69fbqEVueR2CoJ/nVHK8Jku6XxBVBBcvC5Q2f7yBqQRjqkH6fI2ccMrWvL?=
 =?us-ascii?Q?/3tAf/IHU9EJC5xk8cb5yZsX0joaQbRD0ui8ALe3q/l2S8PYU9G0CBbh5rqs?=
 =?us-ascii?Q?9JH0YjCRtWLZ7070QW+uokBy2Z7i5X0kT9KFCrWPL93LlTQFWliVH5KiRK+P?=
 =?us-ascii?Q?3Ug+FTjUzRNJuFXcOdZGuWWhLLiwm10z0zTHFMzwhsWBRZYt6CkFY8DRGaG5?=
 =?us-ascii?Q?YnbTOuuu/w7a9Qey15JWNHQ4qiCaKwafaBDMP1hOe0OMbr0mAz7m8GY2fkdC?=
 =?us-ascii?Q?oIR55cUkQVtmmwSTHS2JMlnZQ8UPypoYgUAaqgKywdmHALUkIMFiSDLsaQaj?=
 =?us-ascii?Q?Q9MdBRttZNMUzAWlKx9rrSgH57HzfVicsaDvDpJn6yt2uecdOKEXk8A6WOeG?=
 =?us-ascii?Q?pFLNQnoc6T0qag189oejSmxnp8iVtVm5s2pUkerUqYUs1CJ8HuRQk90/osAZ?=
 =?us-ascii?Q?F9IRq80/O2iHSQRQaeZzhxJWwTGRKdRuT2jAwD/zCDvNoApyAqz6yzZyK3AT?=
 =?us-ascii?Q?c8rdBqbDz7mDwFUiKfIQ+n1bnbmfJFYcMud5hfTRL6SvvjOqqj53wxgdLXpq?=
 =?us-ascii?Q?dNHU32glwEpKa4ou0cpwepUyzbtEZ0ZLp8y58T5P52FMrz39o6brpzMPs9DE?=
 =?us-ascii?Q?8+FfMU6KcNd2iIIOj0hFguo3uHyHehXxYQBsvK6clqX5rOWg278o5wIEv2Lo?=
 =?us-ascii?Q?dZRai4sjoI3xtLF98l1jMItQ1GIWg2Cz4ucm743cXyqlrLIZO2ounKRzIyDn?=
 =?us-ascii?Q?sJDfRzqBjgjbJtg16Gu+rYG0RKMAGgzBGBaUAgZSOQl0SyKvTq2soo2/WkMz?=
 =?us-ascii?Q?E0NL2uFLMax0/DYfjwuUfcICvH/gYCtt+0hsL5b9uMkl3zf5RoX4YK031LW/?=
 =?us-ascii?Q?SIdqqtKsh80f39xtQYX11QJNdRzDZJJ1zjrixFOHYvnksh7saKdea3fprnOm?=
 =?us-ascii?Q?FurgFC99MFM2dsHUtr+Hqc2FyrcOcs+t5Im+n7H+0X4Ebt1mch35iOc6jMgf?=
 =?us-ascii?Q?8Q6jDn8lcgVJZIowj1gcLQisDTXRdZYli0nAxwlcfZMkuDqVSG/YkklhfIeP?=
 =?us-ascii?Q?HoLt1z7GfHbZ8Ra1ztSf7GTkqyqi5EEUsuS1C9cT27KvDF2qaucsfopLmDaw?=
 =?us-ascii?Q?bk5bZtAOC7Mf7JJI+2YhMF0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R99vMHbKtnoYdVTCnwVsB1c3CDO/yWPSanLL/S2ipqaPlI7R/kB00CXPIYRa?=
 =?us-ascii?Q?kWEnDgSK15/OMQ8XTpJMdrLlPposf7eIrBITt1nLNQ1ujsLko/zp15PJfeZB?=
 =?us-ascii?Q?RdwFlE33YGuQ/MyCZpFmwXKVSM6a0fmEAh8UpDetwWIPJkh6gmEW3Si/fmoq?=
 =?us-ascii?Q?qXRjlolxPX5SpWluz3kYANp3QaUzaTV+GBBVkb8+n86ubz5OHRfRKm6ZbyHk?=
 =?us-ascii?Q?KpNk/BjgP9B0MOCVjha0mCqkAnO36DL2wfLsioYtc2Ce1dD0ykmg7cyRE3ET?=
 =?us-ascii?Q?PIYb3NwNIu+m0kFEQIF11VjDeXuus4qyAi8nbydw8dVRB8F5M+tEMxDG4lzi?=
 =?us-ascii?Q?T4lLz5FIiMW+HuWIiSP8IFq6dfu+uSH3t2miz3N4vZLx4NgoYuGcCNAxCvVL?=
 =?us-ascii?Q?b2GfSwXy4K3J2tAUng/3h5a5hXEq1frjmRYbZLxEPSAzXMxJFodN4xBKX9x6?=
 =?us-ascii?Q?qlAsvaI9uQ/RijiPXgK1V/+KvVKksdHOGGlaRXwGiXqlXkyb4NnlM8O6ScGs?=
 =?us-ascii?Q?EiksarQeY0xSokWOSyZg44AFt/bORHIPJvwRQvaLqCC1oubw2EGkcY+Ai0Ku?=
 =?us-ascii?Q?7Qnzexz97ggb8haQmzWot2PvZuTnNdKlGueDsCEC9bRFAuEfkhcAzr5zJxpv?=
 =?us-ascii?Q?0ie45Twx2Ir17sM4UzO75dUI1Je7a6/dXoigR/u3X4Ymo6OaTDsW2VDr3KSK?=
 =?us-ascii?Q?aCJXxo2wSQJeXF8dzck9kuNDhLuflE4wv+HHrlSQ1HHDNK2iu1H+6y4XJN9H?=
 =?us-ascii?Q?AHLndCdB8v07NIH8IT/Jv9IYKU0gida/+ZzdbykYtIF+3/NSo+91D/HWx9k5?=
 =?us-ascii?Q?5Pz5fLuYklkg2KJF63Ny7iuqnotMT+kLI/qzKYWcjQRcYxau2qi+b2bY1d+q?=
 =?us-ascii?Q?e0z/vpEc4pw+ZX/LQarYayKoAiYI/QiXNTAgQEeexDmA0jkFIMePfvngw8PB?=
 =?us-ascii?Q?hO2md4mItlSNTZUHs8QU0rWfhXK0pWOP36Gi2CtEe2gRvPo8BYNXSrUloYdi?=
 =?us-ascii?Q?6U+0BVapF5BbocsECd67JkXj6HIWbb4ThbIUY0NAfiyGGfOzMExEOO9gIwwk?=
 =?us-ascii?Q?kLtkk/SgvuQwncfob484ySPvJulWR51VcuqYfr1rwhFr5xshgIYp60lnLyue?=
 =?us-ascii?Q?CMkduhAH+xF19Yv6Pk7IMy7ZMrZLw7zAHGU+mqfK3KcL9n1HGvzbhN6Idgqw?=
 =?us-ascii?Q?IPzYLlVlPTNVWOsvGjFalPyYGG2+Dlmy3/Z3AbVIh2cP0FqsA3With03ZiDp?=
 =?us-ascii?Q?ARiZ5Ib+cf46Gtb6qc4cj0r8n/zzfawxyBmalxUnEnRnvOVUDomqXdtmQwr4?=
 =?us-ascii?Q?OY07Hj74ensgvkjRiIEQaaRr68n2dK+2GtcYzdYV1y1K8pRAW868B2KQ5AjZ?=
 =?us-ascii?Q?jz90zd60asx7/qgH1NPy29YxcWmhwL81Uu2oFGIdsLQDTfdEW+ff5rlccU/O?=
 =?us-ascii?Q?mzQ1O41RP9zQp9gEwfM4YP+MLjv5Su0LX7IjpjBlv6py/vUcNTDVe4X1GMp6?=
 =?us-ascii?Q?0/O4vUdvFpjlkctUMDYOnR1PUdroi3iSGh9AONnlewPJ2G8Zcq69DEVVae4d?=
 =?us-ascii?Q?aDAgF/vTevvLQ2LPQksC7Wnh9aL0RcxgCj8hd/9IMyPQWEwU5C+KUIhEqdbL?=
 =?us-ascii?Q?6cY23XL2CjTZZrYiEknF9jW2eHL1tG0oXoKL3lROoYt15D7jY9Eed2IzoupQ?=
 =?us-ascii?Q?LV7jtsruC85luJ4EnOtiMvz/O3SsEnMMPJLSkGuvXEUm8omi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4238133-c83f-499d-392b-08de6f9d0fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 09:55:49.5798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: og7iLK1b9K5nsvIag4+OX5xgDo+H22B/bb79bv8gTEHb4iQ61MRd56gdnMZLYB0f+qXZ0qpgJXSGTEeZ6ARguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8971-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR12MB8120.namprd12.prod.outlook.com:mid,amd.com:email,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 1BCBF15D91A
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, February 18, 2026 9:20 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> mode

---[ Snipped some text to reduce mail size ]---

> > > > > On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K Verma wrote:
> > > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mod=
e.
> > > > > > The current code does not have the mechanisms to enable the
> > > > > > DMA transactions using the non-LL mode. The following two
> > > > > > cases are added with this patch:
> > > > > > - For the AMD (Xilinx) only, when a valid physical base address=
 of
> > > > > >   the device side DDR is not configured, then the IP can still =
be
> > > > > >   used in non-LL mode. For all the channels DMA transactions wi=
ll
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
> > > > > > Changes in v10
> > > > > >   Added the peripheral_config check only for HDMA IP in
> > > > > >   dw_edma_device_config().
> > > > > >   Replaced the loop with single entry retrieval for non-LL
> > > > > >   mode.
> > > > > >   Addressed review comments and handled the burst allocation
> > > > > >   by defining 'bursts_max' as per suggestions.
> > > > > >
> > > > > > Changes in v9
> > > > > >   Fixed compilation errors related to macro name mismatch.
> > > > > >
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
> > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
> > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++------
> > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65
> > > > > > ++++++++++++++++++++++++++-  drivers/dma/dw-edma/dw-hdma-
> v0-
> > > > > regs.h |  1 +
> > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > >  6 files changed, 132 insertions(+), 15 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > index b43255f914f3..ef3d79a9f88d 100644
> > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > @@ -223,6 +223,31 @@ static int dw_edma_device_config(struct
> > > > > dma_chan *dchan,
> > > > > >                                struct dma_slave_config *config)=
  {
> > > > > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > > > > > +     int non_ll =3D 0;
> > > > > > +
> > > > > > +     chan->non_ll =3D false;
> > > > > > +     if (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) {
> > > > >
> > > > > Need handle EMDA case. if mf is EDMA, need return error when
> > > > > config->peripheral_config is not NULL. Or remove above check to
> > > > > config->make
> > > > > code work for both EDMA or HDMA.
> > > > >
> > > >
> > > > For the case of EDMA, the behavior is unchanged.
> > > > Even if the config->peripheral_config param is set then it would
> > > > be simply
> > > ignored.
> > > > This is retention of the previous behavior. This is done because
> > > > device_slave_config has other params which affect the behavior of
> > > > the DMA transactions, we do not check all those params and return
> > > > any error. The error is returned only in the cases where
> > > > particular parameter from dma_slave_config is used and if the
> > > > parameter is not as expected or in the expected form. The
> > > > parameter used from dma_slave_config for the particular IP type
> > > > need to be known first then it
> > > can be checked for its correctness. This is behavior for the
> > > peripheral_config which is used for HDMA and thus error checked.
> > >
> > > It actaully hidden error. Your patch provide an option, which need't
> > > ll memory to do DMA transfer. DMA consumer actaully don't know which
> > > backend used, which is private information by DMA engine providor.
> > >
> > > dw-edma-pcie.c is only one of all edma users, which know DMA
> > > engine's information because it creates this interface.
> > >
> > > PCIE-EP framework also create dmaegine, PCIE-EP function driver use
> > > DMA standard interface to get dma-chan.
> > >
> > > if (config->peripheral_config) { /* only your specific dma consumer
> > > set it now */
> > >         /* optional config information */
> > >         if (chan->dw->chip->mf !=3D EDMA_MF_HDMA_NATIVE) {
> > >                 dev_err("edma have not implmentent no-lll mode\n")
> > >                 return -EINVAL
> > >         }
> > >
> > >         ...
> > > }
> > >
> > > Add EDMA support no-ll mode is quite easily in future.
> > >
> >
> > This looks reasonable provided that HDMA got the support for this param=
.
> > An error check can be added in the next revision.
> > The addition may be slightly different as following:
> > If (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) { ...
> > } else if (config->peripheral_config) {
> >  /* error handling */
> > }
> >
> > Using the above, if support needs to be added to EDMA then a check for
> correct 'mf'
> > in the if() shall be sufficient.
> >
> > > >
> > > > > > +             if (config->peripheral_config &&
> > > > > > +                 config->peripheral_size !=3D sizeof(int)) {
> > > > > > +                     dev_err(dchan->device->dev,
> > > > > > +                             "config param peripheral size mis=
match\n");
> > > > > > +                     return -EINVAL;
> > > > > > +             }
> > > > > > +
> > > > > > +             /*
> > > > > > +              * When there is no valid LLP base address availa=
ble then
> the
> > > > > > +              * default DMA ops will use the non-LL mode.
> > > > > > +              *
> > > > > > +              * Cases where LL mode is enabled and client want=
s to use
> the
> > > > > > +              * non-LL mode then also client can do so via pro=
viding the
> > > > > > +              * peripheral_config param.
> > > > > > +              */
> > > > > > +             if (config->peripheral_config)
> > > > > > +                     non_ll =3D *(int
> > > > > > + *)config->peripheral_config;
> > > > > > +
> > > > > > +             if (chan->dw->chip->non_ll ||
> > > > > > + (!chan->dw->chip->non_ll && non_ll))
> > > > >
> > > > > if chan->dw->chip->non_ll is true, It should return error if you
> > > > > set non_ll false because no LLP base available.
> > > > >
> > > >
> > > > In case the 'chan->dw->chip->non_ll' is true, then the default
> > > >mode  becomes non-LL for HDMA ONLY. There is no option to the user
> > > >to  configure the LL mode by giving 'non_ll =3D false' as part of th=
e
> > > >config- peripheral_config.
> > >
> > > This is API's callback, you can't assume caller do all correct things=
.
> > >
> > > > The configuration of default non-LL mode depends on how the IP is
> > > > programmed by the user. The user is aware of the IP configuration.
> > >
> > > It is not true. DMA consumer don't know such detail information,
> > > which only know which dma engineer providor.
> > >
> >
> > For the DMA consumer the only option is LL mode as default mode. In
> > order to use the non-LL mode it need to provide the parameter in the fo=
rm
> of peripheral_config.
> > Given the above statement, the consumer even if gives the 'non_ll =3D
> > false', it is not going to change any behavior.
> > Even if the user is not giving the option the assumption is that
> > controller is in LL mode, unless the DMA engine provider provides the
> > information regarding non-LL mode as default mode to the DMA consumer
> explicitly.
> > In the case where chan->dw->chip->non_ll =3D true, following case may
> happen:
> > - DMA consumer provides no peripheral_config param or simply config-
> >peripheral_config =3D NULL,
> >    in this case non_ll =3D false which is the current flow.
> > - DMA consumer provides a valid peripheral_config (!=3D NULL) param but=
 the
> value is '0', in this case
> >   It is explicit but it would have the same effect as above case.
> >
> > DMA consumer is supposed to provide the only option non_ll as it was
> > not available and LL mode is set as default for the DMA operations.
> > When 'chan->dw->chip->non_ll =3D true' then this was added to make the
> > chip usable when the LLP base addresses are not configured. Without
> > this, user cannot use any of the modes be it LL or non-LL if the LLP ba=
se
> address is not configured.
>
> little bit confuse, Maybe the same as you. I expected behavor
>
> config->peripheral_config =3D NULL        choose hardware default one
>                                         -           LL mode if hardware s=
upport
>                                         -      none-LL mode if not ll lis=
t region
>
> config->peripheral_config !=3D NULL
> EDMA: return false
> HDMA:
>                 0                       force to none_ll mode. (always su=
ccess)
>                 1                       force back to ll mode  (return fa=
lse if no ll list region in
> chip)
>
> DMA consumer decide if fall back to none_ll to continue.
>

Thank you for the elaboration!
I have few questions, why shall a DMA consumer decide to enable LL mode whe=
n the
default mode supported is LL mode only?

If DMA consumer is trying to enable the LL mode, then one must be knowing t=
he configuration
of the controller that controller is working in non-LL mode, as LLP base ad=
dress is not configured,
then why to try and enable the LL mode?

The user need to know, at least, one detail from the above two cases.

The use for non-LL mode is useful in the following scenario:
- When user want to utilize the LL regions also for DMA data transfers.
- For single and big chunks non-LL mode is useful in both use-cases when no=
n-LL mode is default or
  user enables it via peripheral_config params.
- This addition, inadvertently, makes the DMA controller usable, for AMD (X=
ilinx) only, when the LLP
  base addresses are not configured; it can be used in non-LL mode. For Syn=
opsys, DMA controller
  cannot be used in any mode if LLP base address is not configured.

Based on the above points, if user is trying to enable LL mode when default=
 mode is LL mode, it looks
Intentionally making the choice when user is aware of the mode DMA controll=
er operating in.
Please let me know if this clarifies the doubt.

> >
> > > > The check for non-LL option
> > > > provided by the user is useful when LL-mode is default. That is
> > > > why the value of non_ll =3D=3D false is not even evaluated.
> > > >
> > > > > > +                     chan->non_ll =3D true;
> > > > > > +     }
> > > > > >
> > > ...
> > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > b/include/linux/dma/edma.h index 3080747689f6..78ce31b049ae
> > > > > > 100644
> > > > > > --- a/include/linux/dma/edma.h
> > > > > > +++ b/include/linux/dma/edma.h
> > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > >       enum dw_edma_map_format mf;
> > > > > >
> > > > > >       struct dw_edma          *dw;
> > > > > > +     bool                    non_ll;
> > > > >
> > > > > Can you check ll_region directly? it should be equal to
> > > > > (ll_region->sz =3D=3D 0)
> > > ?
> > >
> > > Do you miss this questin?
> > >
> > > Frank
> > >
> >
> > Yes, looks like I missed this question. Could you explain a little bit =
more? I
> am unable to understand the context.
>
> you set chip->non_ll =3D non_ll in dw_edma_pcie_probe()
>
> and only set ll_region->sz =3D ll_block->sz when !chip->non_ll.
>
> Thats means ll_region->sz is 0 when chip->non_ll is true.
>
> So non_ll have not bring new infomation into dw_edma_chip.
>
> check !ll_region->sz, which should be equal to this non_ll.
>
> dw_edma_chip is the exchange information between controller and dma core
> driver. Needn't cache it here because you already save a copy in dma-chan=
.
>
> Frank

I understand the concern here but it does not look good to piggyback the
non_ll related information on the existing variable.
The use of bool readily points out the information related to what mode is =
being intended
but using the ll_region->sz is an inference the user has to make.

Having ll_region->sz =3D=3D 0 does not really tell it is non_ll mode or not=
, it can also mean that
the size of LL region is zero while in LL mode which could be an error.
This does not translate to support for non-LL mode. This brings the ambigui=
ty.
The introduction of the non_ll provides clarity and easy comparison with th=
e similar
choice (non_ll) provided by the DMA consumer in the dmaengine_slave_config(=
).
I request we shall retain the clarity here.

> >
> > > > >
> > > > > Frank
> > > > > >  };
> > > > > >
> > > > > >  /* Export to the platform drivers */
> > > > > > --
> > > > > > 2.43.0
> > > > > >


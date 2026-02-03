Return-Path: <dmaengine+bounces-8685-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FFaMj3kgWmDLQMAu9opvQ
	(envelope-from <dmaengine+bounces-8685-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:04:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC2D8BE8
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5750630093AD
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 12:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D433BBC8;
	Tue,  3 Feb 2026 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rc1msoR4"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C633C19A;
	Tue,  3 Feb 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120242; cv=fail; b=CfT9kcSbl5oDgdZe3qmhWpvoJko/CmseS/gsXOSD7RxNHz3n6I+teZitloD47NAUnWX/prcfBeTSRZuPRKDaqH3h1mU8/k0CG1+2jMOqy92IDX7g8mNgaGT1bzyg0/hC5dgdECKDZY2Z0NlXIJ8GIgtQasl49AJi19YMCglEUoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120242; c=relaxed/simple;
	bh=JlpBE0yAxN2SGwpYQwesmgZSzcHCGHNUu9fGNZxqJLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dioO+UBzNZIOhIjQ4FvbC76kaS2eqtRMDepI84ct3erkBG93pNfukthw225uN3cG5baH8wOJAq50hNzF1FwnZqox49VIwHKaa3uKjwaGYk9R46NSjtSm767e40tY7wvGbq5GnTwfYPJVUtszdtH1IFuatEreftxY+UWLjzBqq/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rc1msoR4; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnZVu8E2asvnz9IWWKsBKbrR9MY3VkiYXMKdfesEuWs3z4wxT745AY47FyZHvmulGwGRRZpYUkljqGXnlmzYjsHwGrkhwWaKDngBsx0gSHvCvQOeL1i9iEp47mhN4Wfjcu7CWjO6s3Zcc13pPngyDvnk8plappyyzHm6Fn+CK6rL8D29XnFNJ13MFO1y84I4a0AMvM1i1whD6xtxPOOaz1PgKjuBi4H5OTW1rbPBK9f8riRTZqca01D0hYU84jXF1GKTKN6CQNFZWkpmqMu9EZp9pIze1ixFk6ba5Se1pM5fFeNJA/UfXR+X+AUYNCuzYFQswOs+H44yPv/uhF7pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeOSeWWoVmocycSKtfp5NmrWIJWSjCKD3wFPaXXm0GA=;
 b=uwDNNkvSTTVPMHs2t6+TvHK0B8T6NaIQ0beKADGXJX8N/g1hnQytUc7mQFfrq1BVS8K1DIPxxK0IbArwUWwoAHoEwUppeJSRxv0W1Q3qgoVbVz4v9IX8EeE/g0F7DBoAbbY4yA2dZPN2B2cPdR5T8Aadh+1Dysvnurahj15v8c+KWwF75O2lHsf/nv9Gufi/RAW7lQoVJKrMmKZWvS2bBuDK0K8OQoH3JB4pJnz+znV8jlyLXB+t2hjfoLU4lNQjyhs/AzrcIadgccy31jyxVdXGzXU+dmCXzMWQnqORdw1jJr+nLVevG1Kh168KUjTpakcHTqCXvBFP1r3FCDIt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeOSeWWoVmocycSKtfp5NmrWIJWSjCKD3wFPaXXm0GA=;
 b=Rc1msoR4hvQnMl7Y2uaPC2K3rAsmkJ6D3BWSyLzaDfZZK4jnmGvv/exsMovqX4BFnW9wPpYNzoRLEosXMb0dqIjrzuuuBtpckFBLPMIeoPGnfKjNumhnlD9U2PUeisacpH/XFSFv+HfnYzLquOAQpl7Ua8bIyzlNptRcnJfsDF4=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 12:03:55 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 12:03:54 +0000
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
 AQHcgWAk7pWjXdcU0UqtyDITzRPgzrVTd7gAgAE23OCABQPxgIABMzMAgAILjACAAQilwIAG704AgAJHbSCAAJxAAIABNRTQgAgFXXA=
Date: Tue, 3 Feb 2026 12:03:54 +0000
Message-ID:
 <SA1PR12MB8120CEA934BCA561FE860F0C959BA@SA1PR12MB8120.namprd12.prod.outlook.com>
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
 <SA1PR12MB812089EE794D987D1AE48A07959EA@SA1PR12MB8120.namprd12.prod.outlook.com>
In-Reply-To:
 <SA1PR12MB812089EE794D987D1AE48A07959EA@SA1PR12MB8120.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|DM4PR12MB6254:EE_
x-ms-office365-filtering-correlation-id: 72476e04-4405-4650-a58c-08de631c4dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lQyYkv891CHumghjFxEhZsmTuHPpD+PaLIz0WxqP0qK6cnkmDwEJXND9dFCs?=
 =?us-ascii?Q?7RGOdBq7Zy0FsxdSLDxmyh8EEoelVACtDDmks8nGu2zHHTV3dGsyBOFubG+9?=
 =?us-ascii?Q?uJXwImmi2nTK8aqJt20f+Cc6RhbEI7bAa2/vizFLrmfJz3b5ByS5ZnvTGVgr?=
 =?us-ascii?Q?GVyZYcsOEg0u2NVSwSJ79RJ6di3mmr7fcZuwcrrlECii426AZBtCigxwBW14?=
 =?us-ascii?Q?onRnRAAucfNNRgkL5KcKamk10FZ2c3DbBOEni2Mgz2tIp+n2eu2FWGbiuWbR?=
 =?us-ascii?Q?f93r7xSRptnfOHmafExQ0xOWtiEVY6d/UmYppetBKmmh0p8wCfAsHkU+CSSd?=
 =?us-ascii?Q?Z8pW6XZoZoFJ0fOAyxE4A8Fm1+MLnThvWGW2FLb1HkKgJmSlUdqJVva2fk0E?=
 =?us-ascii?Q?v1ZibEIsRwD8C47dae4d0a3mwDSO7WywZr/VZMc0WUG1EoylmFKyLXB+sI9+?=
 =?us-ascii?Q?JLAtLhrfqphKuF2aUJYHu7/gTZiBuMX9mUn1sUfnA9+QCJylfUxQ6TSzjUGs?=
 =?us-ascii?Q?dj+fwYRN0Pu83bLl15PyroTYyu4hBmD+KS52WJO+ZMJmRQouK6h56o62TJ1V?=
 =?us-ascii?Q?dvUDZyX1jeSsuZF/kYHjuwayv6xFkvscEv7VrtMugM+Eh/+KjcFIn2Zp9nTz?=
 =?us-ascii?Q?q7XRUzBqYkW7I0/NWtnP+I6cLj7FaaAXfIHnas9CEOzpCkdjaAuPu6ALNpH2?=
 =?us-ascii?Q?1zpf6Grr1uv2oJwsYwOrvOz9sdG8BCzhmugjg1C0RELaj2wJaD9RD6zeHjuM?=
 =?us-ascii?Q?B+2x924mu7ZAmImtWqMpYvg4IgziBizELuAGWnuKck636qvsTmSK+w4gVhJ0?=
 =?us-ascii?Q?/jlrqOfeS+Wl8y2U03MNKgIY/e8YrZ0w0YvgBGPEPZXtBa0dQY27o0Y5eqT6?=
 =?us-ascii?Q?LE6sEFYUcNQbdRbiAYveBoQSMRk/ATRGHRFalhzAs87lGCVpDYKUeGpd3ojo?=
 =?us-ascii?Q?Y5CauvKWQrShugbpiLc/qvbnsicSk1R7uko/lwa+GGdaDKcCbSD2X1rgX7tA?=
 =?us-ascii?Q?6q0/s67lC3FDEDRQO92sQXtVfYmcNIc9QC1mHEAY+n0C3RKz9ZwT+xHfkvaK?=
 =?us-ascii?Q?TYUzdTA1PT0XH/AS7pfavMYMH9LcyFQyxlRz+2ch92JBxbnnVOLIWuJ/tD4O?=
 =?us-ascii?Q?sEo911dEFsxIJboQMZur4BfIEAB5gknciWcvQ156nxxeosFNbAu6wOiFbYei?=
 =?us-ascii?Q?HD1H67PGxhtdmZcOe3EHf6Ez6WpRWk6bZJ323XqvUwYDBqLsL8D2xLpEl7Ak?=
 =?us-ascii?Q?bnhn6K5T7n3ijiKosEqSOWMziZKIP9d5wUp2yQXM7vipT0NHJT7yH5aTZ6Fr?=
 =?us-ascii?Q?YGgEpwQLb/h6HHVAROTkcAJaDA8YbdSVzXJDC5OSbEOD7uSUUEChnGaDA5qv?=
 =?us-ascii?Q?0HFXjs95YzYhqX2DhUt30LVkgzkBdZ6jc+uGkyKgzmKwefvuJTKnPvrw5Hjh?=
 =?us-ascii?Q?+84W4C7hFMitQBEFoaK0B4Qc809cGztInmjmtd5fnYamK+qGVQWc3sh+VOzI?=
 =?us-ascii?Q?wsmA9Oc77dnWxi1s+AYc5dvGWbyCjvo3jy0NUAo72LZxzUQs0cBFsRCi/Ryo?=
 =?us-ascii?Q?2klpnm1gl+psAsLMmhQuiamet6JpSS0t57hSJ1u1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i/KoNT74ltGNyu5ygXtQYYB4d2oa67anCnsbYNwDGSdlN6D8wRwKiYc8om2U?=
 =?us-ascii?Q?Z+5AP0wtlhwdd5MsdH/zfQyzpXollEDyzl4TFaeyXT/mQqux045LxqziEDTd?=
 =?us-ascii?Q?VzAO3VlQx8Gnv3OJsw9AQugSdJbbK6Gve0LKLhdF+huxeqr7Ds2O7aYXLOLR?=
 =?us-ascii?Q?hhJL29w/+gqgtJbzl2G9dK7SMZFUdfwPvUipPlNMCdubPDOze0znifV4pM8H?=
 =?us-ascii?Q?ubwsdVT0vTRBSe71WiUg2nhcBNlQPPVIoYViKD8Vm8qsPL8/YKyVzfk+c3dh?=
 =?us-ascii?Q?gNp8kJurGYo06kRu4ublOlG/9EV/7OhfeWi7bE3p8r9U03RuZq3Uyppl8ydg?=
 =?us-ascii?Q?yxcYTktUNCzPT4U8onkIudIgu6sf+ILLb3lveYUr4ISM8OkF+Qx5WodxMxsi?=
 =?us-ascii?Q?Xk445GF1WjqTWrab+B5sJHcD+RPaHJUKdecuVi3g3HyJlX6PvaQEwOWz/dEH?=
 =?us-ascii?Q?Dzwhswkb+lUhYm7/Jwi2E2jdE7wQnjOug91EicDHPdAs0M5zdWLLjFL9SI13?=
 =?us-ascii?Q?fUHStib5P67EW6MqcwxeU5A0Rcq6x2AY3oljAns4dhbSmVoxJgjO52Xwa6V4?=
 =?us-ascii?Q?NhGYwG3SgXi2Nd4Rle/ESIx/SKhnQDxdWXNFGvBN7qqEraGOJiuyUNfqzxKS?=
 =?us-ascii?Q?Hi5rsZFl3vjM+UccaWSsFWo/6SkLs0smJo7NQgAmQIH1Y7LNXr/pUROhF0ln?=
 =?us-ascii?Q?WVBbOZFTqgJwpeYeApcQe3pWZdgSMwtbMCaGHfB2l3CLPtHK+gHDuNyJKS/e?=
 =?us-ascii?Q?EL9bE0zO3HNKcGQUSU5WlBwPheIHlHUfQHGqy1rrDjW9nH+fZMiGpIr3OSSk?=
 =?us-ascii?Q?oIanGcP7iIxyPnI7rXKj6fay+9kOVxu5KILxuPVd/QOk4pAEVXpHVT2TesdV?=
 =?us-ascii?Q?qpTx12UTAMpJXz/Um9+Jo8rjzbwAeMNSdGnHeyZKcbchOG6YbZSi0d+B5UQe?=
 =?us-ascii?Q?TonxNV8jWKxqcLVv2SHe936+5B3/mpmmSrNUyoQ5A/EdytVjzUYTGIUGNONk?=
 =?us-ascii?Q?PGMTs9pPv8DyR1hvOQHP0o+lDaC5VOXbm/vZvg8P7haV7jpybKAevRhbicHB?=
 =?us-ascii?Q?LAM3QOBaUYJphOjZ8Xdu6l9yqmoYYrRykeFWLao8OX13A6Wn7RC2tsh7hpeB?=
 =?us-ascii?Q?mIL/RPtDKro7INv+jC6reIigQVlD/yueLWO6c+ygnmEpG+Bu3ZN++xnrKUdq?=
 =?us-ascii?Q?984rY8ePY7CEWBZbG5sOAllEsZHV5/Z9jGeojiZGF9538z3YZIA7LOazOdlj?=
 =?us-ascii?Q?RfqkgnWjQpu8HGme468UD1F5gdgJCDjusFqbdWPmE9HO+VSIJLQ6LwS8OYuv?=
 =?us-ascii?Q?d8VrAmsx3ObLrA9EV9fxAUywCc/Jt1aiw0/89vXsiw56etl1oFgGichBTagC?=
 =?us-ascii?Q?12CeGVuUuZPi7YzqpB+P8+paVSzEnxRRqlJcuu/EIxvWb/3ZHO31apJX9wtO?=
 =?us-ascii?Q?u/T2pUqKpcSqq7YCJroEfrsF1bwHUzH8CTgJ4+KLSgh3LB80VsiwaAnJrwJj?=
 =?us-ascii?Q?QolXE3JXuxuj2bv20yMRzYkd9vW4NYyfjkN/W9q6MKgXugviaKU4vMT34NqR?=
 =?us-ascii?Q?9jjOOxWZBeSvRxgkUjL7hExbsv+a6TJrTvAmK52CvFXwCKkOCH0vZYH8MCbq?=
 =?us-ascii?Q?4LBEg5Cu8gx8ugODTYSaHOQ8QBtKmO5bl6Pn0nUf+ioI1sVsgWgcWApGZqY9?=
 =?us-ascii?Q?+5ChJaCv2IjzJgTLwtLwtNx6HHkkYfLkcDH30y9A2DbMX4gE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72476e04-4405-4650-a58c-08de631c4dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 12:03:54.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCJC6bNRhyVHYrYrtcnyifIwOmuKpFmInJEq1DAjYLzNPR+lrAproK6di01fR4Xa2VYBW+JlHaiBLCCV2Yu7GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8685-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,outlook.com:url,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CBC2D8BE8
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Frank

Any update on this review?

Regards,
Devendra

> -----Original Message-----
> From: Verma, Devendra <Devendra.Verma@amd.com>
> Sent: Thursday, January 29, 2026 5:26 PM
> To: Frank Li <Frank.li@nxp.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Verma,
> Devendra <Devendra.Verma@amd.com>
> Subject: RE: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Wednesday, January 28, 2026 8:38 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
>
> --[ Snipped some headers to reduce the size of this mail ]--
>
> > > > > > > > > > > AMD MDB IP supports Linked List (LL) mode as well as
> > > > > > > > > > > non-LL
> > > > mode.
> > > > > > > > > > > The current code does not have the mechanisms to
> > > > > > > > > > > enable the DMA transactions using the non-LL mode.
> > > > > > > > > > > The following two cases are added with this patch:
> > > > > > > > > > > - For the AMD (Xilinx) only, when a valid physical
> > > > > > > > > > > base
> > address of
> > > > > > > > > > >   the device side DDR is not configured, then the IP =
can still
> be
> > > > > > > > > > >   used in non-LL mode. For all the channels DMA
> > > > > > > > > > > transactions will
> > > > > > > > > >
> > > > > > > > > > If DDR have not configured, where DATA send to in
> > > > > > > > > > device side by non-LL mode.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > The DDR base address in the VSEC capability is used for
> > > > > > > > > driving the DMA transfers when used in the LL mode. The
> > > > > > > > > DDR is configured and present all the time but the DMA
> > > > > > > > > PCIe driver uses this DDR base address (physical
> > > > > > > > > address) to configure the LLP
> > > > address.
> > > > > > > > >
> > > > > > > > > In the scenario, where this DDR base address in VSEC
> > > > > > > > > capability is not configured then the current controller
> > > > > > > > > cannot be used as the default mode supported is LL mode o=
nly.
> > > > > > > > > In order to make the controller usable non-LL mode is
> > > > > > > > > being added which just needs SAR, DAR, XFERLEN and
> > > > > > > > > control register to initiate the transfer. So, the DDR
> > > > > > > > > is always present, but the DMA PCIe driver need to know
> > > > > > > > > the DDR base physical address to make the transfer. This
> > > > > > > > > is useful in scenarios where the memory
> > > > > > > > allocated for LL can be used for DMA transactions as well.
> > > > > > > >
> > > > > > > > Do you means use DMA transfer LL's context?
> > > > > > > >
> > > > > > >
> > > > > > > Yes, the device side memory reserved for the link list to
> > > > > > > store the descriptors, accessed by the host via BAR_2 in
> > > > > > > this driver
> > code.
> > > > > > >
> > > > > > > > >
> > > > > > > > > > >   be using the non-LL mode only. This, the default
> > > > > > > > > > > non-LL
> > mode,
> > > > > > > > > > >   is not applicable for Synopsys IP with the current
> > > > > > > > > > > code
> > addition.
> > > > > > > > > > >
> > > > > > > > > > > - If the default mode is LL-mode, for both AMD
> > > > > > > > > > > (Xilinx) and
> > > > Synosys,
> > > > > > > > > > >   and if user wants to use non-LL mode then user can
> > > > > > > > > > > do so
> > via
> > > > > > > > > > >   configuring the peripheral_config param of
> > dma_slave_config.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Devendra K Verma
> > > > > > > > > > > <devendra.verma@amd.com>
> > > > > > > > > > > ---
> > > > > > > > > > > Changes in v8
> > > > > > > > > > >   Cosmetic change related to comment and code.
> > > > > > > > > > >
> > > > > > > > > > > Changes in v7
> > > > > > > > > > >   No change
> > > > > > > > > > >
> > > > > > > > > > > Changes in v6
> > > > > > > > > > >   Gave definition to bits used for channel configurat=
ion.
> > > > > > > > > > >   Removed the comment related to doorbell.
> > > > > > > > > > >
> > > > > > > > > > > Changes in v5
> > > > > > > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > > > > > > >   In the dw_edma_device_config() WARN_ON replaced
> > > > > > > > > > > with
> > > > > > dev_err().
> > > > > > > > > > >   Comments follow the 80-column guideline.
> > > > > > > > > > >
> > > > > > > > > > > Changes in v4
> > > > > > > > > > >   No change
> > > > > > > > > > >
> > > > > > > > > > > Changes in v3
> > > > > > > > > > >   No change
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2
> > > > > > > > > > >   Reverted the function return type to u64 for
> > > > > > > > > > >   dw_edma_get_phys_addr().
> > > > > > > > > > >
> > > > > > > > > > > Changes in v1
> > > > > > > > > > >   Changed the function return type for
> > > > dw_edma_get_phys_addr().
> > > > > > > > > > >   Corrected the typo raised in review.
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 42
> > > > > > > > +++++++++++++++++++++---
> > > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46
> > > > > > ++++++++++++++++++--
> > > > > > > > ------
> > > > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > > > > > > > > > ++++++++++++++++++++++++++++++++++-
> > > > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > > > > > > > > >
> > > > > > > > > > edma-v0-core.c have not update, if don't support, at
> > > > > > > > > > least need return failure at dw_edma_device_config()
> > > > > > > > > > when backend is
> > > > eDMA.
> > > > > > > > > >
> > > > > > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > > > > > >  6 files changed, 132 insertions(+), 20 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > index b43255f..d37112b 100644
> > > > > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > @@ -223,8 +223,32 @@ static int
> > > > > > > > > > > dw_edma_device_config(struct
> > > > > > > > > > dma_chan *dchan,
> > > > > > > > > > >                                struct dma_slave_confi=
g *config)  {
> > > > > > > > > > >       struct dw_edma_chan *chan =3D
> > > > > > > > > > > dchan2dw_edma_chan(dchan);
> > > > > > > > > > > +     int non_ll =3D 0;
> > > > > > > > > > > +
> > > > > > > > > > > +     if (config->peripheral_config &&
> > > > > > > > > > > +         config->peripheral_size !=3D sizeof(int)) {
> > > > > > > > > > > +             dev_err(dchan->device->dev,
> > > > > > > > > > > +                     "config param peripheral size m=
ismatch\n");
> > > > > > > > > > > +             return -EINVAL;
> > > > > > > > > > > +     }
> > > > > > > > > > >
> > > > > > > > > > >       memcpy(&chan->config, config,
> > > > > > > > > > > sizeof(*config));
> > > > > > > > > > > +
> > > > > > > > > > > +     /*
> > > > > > > > > > > +      * When there is no valid LLP base address
> > > > > > > > > > > + available then the
> > > > > > default
> > > > > > > > > > > +      * DMA ops will use the non-LL mode.
> > > > > > > > > > > +      *
> > > > > > > > > > > +      * Cases where LL mode is enabled and client
> > > > > > > > > > > + wants to use the
> > > > > > non-LL
> > > > > > > > > > > +      * mode then also client can do so via
> > > > > > > > > > > + providing the
> > > > > > peripheral_config
> > > > > > > > > > > +      * param.
> > > > > > > > > > > +      */
> > > > > > > > > > > +     if (config->peripheral_config)
> > > > > > > > > > > +             non_ll =3D *(int
> > > > > > > > > > > + *)config->peripheral_config;
> > > > > > > > > > > +
> > > > > > > > > > > +     chan->non_ll =3D false;
> > > > > > > > > > > +     if (chan->dw->chip->non_ll ||
> > > > > > > > > > > + (!chan->dw->chip->non_ll &&
> > > > > > non_ll))
> > > > > > > > > > > +             chan->non_ll =3D true;
> > > > > > > > > > > +
> > > > > > > > > > >       chan->configured =3D true;
> > > > > > > > > > >
> > > > > > > > > > >       return 0;
> > > > > > > > > > > @@ -353,7 +377,7 @@ static void
> > > > > > > > > > > dw_edma_device_issue_pending(struct
> > > > > > > > > > dma_chan *dchan)
> > > > > > > > > > >       struct dw_edma_chan *chan =3D
> > > > > > > > > > > dchan2dw_edma_chan(xfer-
> > > > > > >dchan);
> > > > > > > > > > >       enum dma_transfer_direction dir =3D xfer->direc=
tion;
> > > > > > > > > > >       struct scatterlist *sg =3D NULL;
> > > > > > > > > > > -     struct dw_edma_chunk *chunk;
> > > > > > > > > > > +     struct dw_edma_chunk *chunk =3D NULL;
> > > > > > > > > > >       struct dw_edma_burst *burst;
> > > > > > > > > > >       struct dw_edma_desc *desc;
> > > > > > > > > > >       u64 src_addr, dst_addr; @@ -419,9 +443,11 @@
> > > > > > > > > > > static void dw_edma_device_issue_pending(struct
> > > > > > > > > > dma_chan *dchan)
> > > > > > > > > > >       if (unlikely(!desc))
> > > > > > > > > > >               goto err_alloc;
> > > > > > > > > > >
> > > > > > > > > > > -     chunk =3D dw_edma_alloc_chunk(desc);
> > > > > > > > > > > -     if (unlikely(!chunk))
> > > > > > > > > > > -             goto err_alloc;
> > > > > > > > > > > +     if (!chan->non_ll) {
> > > > > > > > > > > +             chunk =3D dw_edma_alloc_chunk(desc);
> > > > > > > > > > > +             if (unlikely(!chunk))
> > > > > > > > > > > +                     goto err_alloc;
> > > > > > > > > > > +     }
> > > > > > > > > >
> > > > > > > > > > non_ll is the same as ll_max =3D 1. (or 2, there are
> > > > > > > > > > link back
> > entry).
> > > > > > > > > >
> > > > > > > > > > If you set ll_max =3D 1, needn't change this code.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > The ll_max is defined for the session till the driver is
> > > > > > > > > loaded in the
> > > > > > kernel.
> > > > > > > > > This code also enables the non-LL mode dynamically upon
> > > > > > > > > input from the DMA client. In this scenario, touching
> > > > > > > > > ll_max would not be a good idea as the ll_max controls
> > > > > > > > > the LL entries for all the DMA channels not just for a
> > > > > > > > > single DMA
> > transaction.
> > > > > > > >
> > > > > > > > You can use new variable, such as ll_avail.
> > > > > > > >
> > > > > > >
> > > > > > > In order to separate out the execution paths a new
> > > > > > > meaningful variable
> > > > > > "non_ll"
> > > > > > > is used. The variable "non_ll" alone is sufficient. Using
> > > > > > > another variable along side "non_ll" for the similar purpose
> > > > > > > may not have any
> > > > > > added advantage.
> > > > > >
> > > > > > ll_avail can help debug/fine tune how much impact preformance
> > > > > > by adjust ll length. And it make code logic clean and consisten=
t.
> > > > > > also ll_avail can help test corner case when ll item small.
> > > > > > Normall case it is
> > > > hard to reach ll_max.
> > > > > >
> > > > >
> > > > > Thank you for your suggestion. The ll_max is max limit on the
> > > > > descriptors that can be accommodated on the device side DDR. The
> > > > > ll_avail
> > > > will always be less than ll_max.
> > > > > The optimization being referred can be tried without even having
> > > > > to declare the ll_avail cause the number of descriptors given
> > > > > can be controlled by the DMA client based on the length argument
> > > > > to the
> > > > dmaengine_prep_* APIs.
> > > >
> > > > I optimzied it to allow dynatmic appended dma descriptors.
> > > >
> > > > https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-
> > > > 9a98c9c98536@nxp.com/T/#t
> > > >
> > > > > So, the use of dynamic ll_avail is not necessarily required.
> > > > > Without increasing the ll_max, ll_avail cannot be increased. In
> > > > > order to increase ll_max one may need to alter size and
> > > > > recompile this
> > driver.
> > > > >
> > > > > However, the requirement of ll_avail does not help for the
> > > > > supporting the
> > > > non-LL mode.
> > > > > For non-LL mode to use:
> > > > > 1) Either LL mode shall be not available, as it can happen for th=
e Xilinx
> IP.
> > > > > 2) User provides the preference for non-LL mode.
> > > > > For both above, the function calls are different which can be
> > > > > differentiated by using the "non_ll" flag. So, even if I try to
> > > > > accommodate ll_avail, the call for LL or non-LL would be
> > > > > ambiguous as in
> > > > case of LL mode also we can have a single descriptor as similar to
> > > > non-LL mode.
> > > > > Please check the function dw_hdma_v0_core_start() in this review
> > > > > where the decision is taken Based on non_ll flag.
> > > >
> > > > We can treat ll_avail =3D=3D 1 as no_ll mode because needn't set ex=
tra
> > > > LL in memory at all.
> > > >
> > >
> > > I analyzed the use of ll_avail but I think the use of this variable
> > > does not fit at this location in the code for the following reasons:
> > > 1. The use of a new variable breaks the continuity for non-LL mode.
> > > The
> > variable
> > >     name non_ll is being used for driving the non-LL mode not only
> > > in this file
> > but also
> > >    in the files relevant to HDMA. This flag gives the clear
> > > indication of LL vs
> > non-LL mode.
> > >    In the function dw_hdma_v0_core_start(), non_ll decided the mode
> > > to
> > choose.
> > > 2. The use of "ll_avail" is ambiguous for both the modes. First, it
> > > is
> > associated with LL mode only.
> > >      It will be used for optimizing / testing the Controller
> > > performance based
> > on the
> > >     number of descriptors available on the Device DDR side which is
> > > for LL
> > mode. So when
> > >     it is being used for LL mode then it is obvious that it excludes
> > > any use for
> > non-LL mode.
> > >     In the API dw_edma_device_transfer(), the ll_avail will be used
> > > for
> > creating the bursts.
> > >     If ll_avail =3D 1 in the above API, then it is ambiguous whether
> > > it is creating
> > the burst for
> > >      LL or non-LL mode. In the above API, the non_ll is sufficient
> > > to have the
> > LL mode
> > >      and non-LL burst allocation related piece of code.
> >
> > If really like non-ll, you'd better set ll_avail =3D 1 in prepare code.
> > Normal case ll_avail should be ll_max. It will reduce if-else branch
> > in prep dma burst code.
> >
>
> I think we are not on the same page, and it is creating confusion.
> If non_ll flag is being used to differentiate between the modes, then in =
this
> scenario the use of ll_avail does not fit any requirement related to
> differentiation of different modes. In the last response, I pointed out t=
hat
> ll_avail, if used, creates ambiguity rather than bringing clarity for bot=
h LL &
> non-LL mode. If non_ll flag is used and initialized properly then this is
> sufficient to drive the execution for non-LL mode.
>
> In the function doing the preparation, there also no if-else clause is
> introduced rather the same "if" condition is extended to support the non-=
LL
> mode.
>
> Could you elaborate what is the approach using ll_avail if I need to main=
tain
> the continuity of the non-LL context and use non-LL mode without any
> ambiguity anywhere, instead of using non_ll flag?
> If possible, please give a code snippet. Depending upon the usability and
> issue it fixes, I will check its feasibility.
>
> > +               /*
> > +                * For non-LL mode, only a single burst can be handled
> > +                * in a single chunk unlike LL mode where multiple burs=
ts
> > +                * can be configured in a single chunk.
> > +                */
> >
> > It is actually wrong, current software should handle that. If there
> > are multiple bursts, only HEAD of bursts trigger DMA, in irq handle,
> > it will auto move to next burst. (only irq latency is bigger compared
> > to LL, software's resule is the same).
> >
> > The code logic is totally equal ll_max =3D 1, except write differece re=
gisters.
> >
>
> Changing the ll_max dynamically for a single request is not feasible. As
> pointed out earlier it may require the logic to retain the initially conf=
igured
> value, during the probe, and then use the retained value depending on the
> use-case.
> Could you elaborate the statement,
> " The code logic is totally equal ll_max =3D 1, except write differece re=
gisters." ?
>
> The irq_handler() for success case calls dw_edma_start_transfer() which
> schedules the chunks not bursts. The bursts associated with that chunk wi=
ll
> get written to controller DDR area / scheduled (for non-LL) in the
> dw_hdma_v0_core_start(), for HDMA.
> With this flow, for the non-LL mode each chunk needs to contain a single
> burst as controller can handle only one burst at a time in non-LL mode.
>
>
> > And anthor important is that,
> >
> > in dw_edma_device_config() should return if backend is not HDMA.
> >
>
> Thanks, this is a valid concern, will address in the upcoming version.
>
> > Frank
> >
> > >
> > > I think ll_avail, if used for trying out to optimize / debug the
> > > settings related to number of descriptors for LL mode then it should
> > > be part of the separate discussion / update not related to non-LL.
> > >
> > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > ...
> > > > > > > > > > > +
> > > > > > > > > > > + ll_block->bar);
> > > > > > > > > >
> > > > > > > > > > This change need do prepare patch, which only change
> > > > > > > > > > pci_bus_address() to dw_edma_get_phys_addr().
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > This is not clear.
> > > > > > > >
> > > > > > > > why not. only trivial add helper patch, which help
> > > > > > > > reviewer
> > > > > > > >
> > > > > > >
> > > > > > > I was not clear on the question you asked.
> > > > > > > It does not look justified when a patch is raised alone just
> > > > > > > to replace this
> > > > > > function.
> > > > > > > The function change is required cause the same code *can*
> > > > > > > support different IPs from different vendors. And, with this
> > > > > > > single change alone in the code the support for another IP
> > > > > > > is added. That's why it is easier to get the reason for the
> > > > > > > change in the function name and
> > > > syntax.
> > > > > >
> > > > > > Add replace pci_bus_address() with dw_edma_get_phys_addr() to
> > > > > > make review easily and get ack for such replacement patches.
> > > > > >
> > > > > > two patches
> > > > > > patch1, just replace exist pci_bus_address() with
> > > > > > dw_edma_get_phys_addr() patch2, add new logic in
> > > > dw_edma_get_phys_addr() to support new vendor.
> > > > > >
> > > > >
> > > > > I understand your concern about making the review easier.
> > > > > However, given that we've been iterating on this patch series
> > > > > since September and are now at v9, I believe the current
> > > > > approach is justified. The function renames from
> > > > > pci_bus_address() to dw_edma_get_phys_addr() is directly tied to
> > > > > the non-LL mode functionality being added - it's needed because
> > > > > the same code now supports different IPs from different vendors.
> > > > >
> > > > > Splitting this into a separate preparatory patch at this stage
> > > > > would further delay the review process. The change is kind of
> > > > > straightforward and the context is clear within the current patch=
.
> > > > > I request
> > > > you to review this patch to avoid additional review cycles.
> > > > >
> > > > > This also increases the work related to testing and maintaining
> > > > > multiple
> > > > patches.
> > > > > I have commitment for delivery of this, and I can see adding one
> > > > > more series definitely add 3-4 months of review cycle from here.
> > > > > Please excuse me but this code has already
> > > >
> > > > Thank you for your persevere.
> > > >
> > >
> > > Thank you for your support.
> > >
> > > > > been reviewed extensively by other reviewers and almost by you
> > > > > as well. You can check the detailed discussion wrt this function
> > > > > at the following
> > > > link:
> > > > >
> > > >
> >
> https://lore.kernel.org/all/SA1PR12MB8120341DFFD56D90EAD70EDE9514A@
> > > > SA1
> > > > > PR12MB8120.namprd12.prod.outlook.com/
> > > > >
> > > >
> > > > But still not got reviewed by tags. The recently,  Manivannan
> > > > Sadhasivam , Niklas Cassel and me active worked on this driver.
> > > > You'd better to get their feedback. Bjorn as pci maintainer to
> > > > provide
> > generally feedback.
> > > >
> > >
> > > Hi Manivannan Sadhasivam, Vinod Koul and Bjorn Helgaas Could you
> > > please provide your feedback on the patch?
> > > You have reviewed these patches extensively on the previous versions
> > > of
> > the same series.
> > >
> > > Regards,
> > > Devendra
> > >
> > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > >               ll_region->paddr +=3D ll_block->off;
> > > > > > > > > > >               ll_region->sz =3D ll_block->sz;
> > > > > > > > > > >
> > > > > > ...
> > > > > > > > > > >
> > > > > > > > > > > +static void dw_hdma_v0_core_non_ll_start(struct
> > > > > > > > > > > +dw_edma_chunk
> > > > > > > > > > *chunk)
> > > > > > > > > > > +{
> > > > > > > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > > > > > > +     struct dw_edma *dw =3D chan->dw;
> > > > > > > > > > > +     struct dw_edma_burst *child;
> > > > > > > > > > > +     u32 val;
> > > > > > > > > > > +
> > > > > > > > > > > +     list_for_each_entry(child,
> > > > > > > > > > > + &chunk->burst->list,
> > > > > > > > > > > + list) {
> > > > > > > > > >
> > > > > > > > > > why need iterated list, it doesn't support ll. Need
> > > > > > > > > > wait for irq to start next
> > > > > > > > one.
> > > > > > > > > >
> > > > > > > > > > Frank
> > > > > > > > >
> > > > > > > > > Yes, this is true. The format is kept similar to LL mode.
> > > > > > > >
> > > > > > > > Just fill one. list_for_each_entry() cause confuse.
> > > > > > > >
> > > > > > > > Frank
> > > > > > >
> > > > > > > I see, we can use list_first_entry_or_null() which is
> > > > > > > dependent on giving the type of pointer, compared to this
> > > > > > > list_for_each_entry() looks neat and agnostic to the pointer
> > > > > > > type being used. Though, it can be
> > > > > > explored further.
> > > > > > > Also, when the chunk is allocated, the comment clearly
> > > > > > > spells out how the allocation would be for the non LL mode
> > > > > > > so it is evident that each chunk would have single entry and
> > > > > > > with that understanding it is clear that loop will also be
> > > > > > > used in a similar manner, to retrieve a single entry. It is
> > > > > > > a similar use case as of "do {}while (0)" albeit needs a
> > > > > > > context to
> > > > > > understand it.
> > > > > >
> > > > > > I don't think so. list_for_each_entry() is miss leading to
> > > > > > reader think it is not only to one item in burst list, and use
> > > > > > polling method to to finish many burst transfer.
> > > > > >
> > > > > > list_for_each_entry() {
> > > > > >         ...
> > > > > >         readl_timeout()
> > > > > > }
> > > > > >
> > > > > > Generally, EDMA is very quick, polling is much quicker than
> > > > > > irq if data is
> > > > small.
> > > > > >
> > > > > > Frank
> > > > > >
> > > > >
> > > > > The polling is not required. The single burst will raise the
> > > > > interrupt and from the interrupt context another chunk will be
> > > > > scheduled. This cycle repeats till all the chunks with single
> > > > > burst are
> > exhausted.
> > > > >
> > > > > The following comment made in function dw_edma_device_transfer()
> > > > > in the same patch makes it amply clear that only a single burst
> > > > > would be
> > > > handled for the non-LL mode.
> > > > > +       /*
> > > > > +        * For non-LL mode, only a single burst can be handled
> > > > > +        * in a single chunk unlike LL mode where multiple bursts
> > > > > +        * can be configured in a single chunk.
> > > > > +        */
> > > > >
> > > > > Looking at the way bursts are appended to chunks and chunks in
> > > > > dw_edma_device_transfer() are scheduled for non-LL mode then it
> > > > > is clear
> > > > what non-LL mode would handle in terms of bursts.
> > > > > I just kept the format to match it with the LL mode format
> > > > > otherwise there is no need of this comment and we can follow the
> > > > > syntax for a single
> > > > entry alone.
> > > > > Please share your suggestion if these descriptions fail to
> > > > > provide the clear
> > > > context and intent.
> > > >
> > > > Avoid use list_for_each_entry() here to prevent miss-leading.
> > > >
> > > > Frank
> > > >
> > >
> > > Sure, thanks, I will push this change in next version.
> > >
> > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > + ch_en, HDMA_V0_CH_EN);
> > > > > > > > > > > +
> > > > > > > > > > > +             /* Source address */
> > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.=
lsb,
> > > > > > > > > > > +                       lower_32_bits(child->sar));
> > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.=
msb,
> > > > > > > > > > > +                       upper_32_bits(child->sar));
> > > > > > > > > > > +
> > > > > > > > > > > +             /* Destination address */
> > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.=
lsb,
> > > > > > > > > > > +                       lower_32_bits(child->dar));
> > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.=
msb,
> > > > > > > > > > > +                       upper_32_bits(child->dar));
> > > > > > > > > > > +
> > > > > > > > > > > +             /* Transfer size */
> > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > + transfer_size,
> > > > > > > > > > > + child->sz);
> > > > > > > > > > > +
> > > > > > > > > > > +             /* Interrupt setup */
> > > > > > > > > > > +             val =3D GET_CH_32(dw, chan->dir,
> > > > > > > > > > > + chan->id, int_setup)
> > |
> > > > > > > > > > > +                             HDMA_V0_STOP_INT_MASK |
> > > > > > > > > > > +                             HDMA_V0_ABORT_INT_MASK =
|
> > > > > > > > > > > +
> > > > > > > > > > > + HDMA_V0_LOCAL_STOP_INT_EN |
> > > > > > > > > > > +
> > > > > > > > > > > + HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > > > > > > > > +
> > > > > > > > > > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LO=
CAL)) {
> > > > > > > > > > > +                     val |=3D HDMA_V0_REMOTE_STOP_IN=
T_EN |
> > > > > > > > > > > +                            HDMA_V0_REMOTE_ABORT_INT=
_EN;
> > > > > > > > > > > +             }
> > > > > > > > > > > +
> > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > + int_setup, val);
> > > > > > > > > > > +
> > > > > > > > > > > +             /* Channel control setup */
> > > > > > > > > > > +             val =3D GET_CH_32(dw, chan->dir, chan->=
id, control1);
> > > > > > > > > > > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > + control1, val);
> > > > > > > > > > > +
> > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, door=
bell,
> > > > > > > > > > > +                       HDMA_V0_DOORBELL_START);
> > > > > > > > > > > +     }
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +static void dw_hdma_v0_core_start(struct
> > > > > > > > > > > +dw_edma_chunk *chunk, bool
> > > > > > > > > > > +first) {
> > > > > > > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > > > > > > +
> > > > > > > > > > > +     if (chan->non_ll)
> > > > > > > > > > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > > > > > > > > > +     else
> > > > > > > > > > > +             dw_hdma_v0_core_ll_start(chunk,
> > > > > > > > > > > + first); }
> > > > > > > > > > > +
> > > > > > > > > > >  static void dw_hdma_v0_core_ch_config(struct
> > > > > > > > > > > dw_edma_chan
> > > > > > > > > > > *chan)
> > > > > > > > {
> > > > > > > > > > >       struct dw_edma *dw =3D chan->dw; diff --git
> > > > > > > > > > > a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > index eab5fd7..7759ba9 100644
> > > > > > > > > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > @@ -12,6 +12,7 @@
> > > > > > > > > > >  #include <linux/dmaengine.h>
> > > > > > > > > > >
> > > > > > > > > > >  #define HDMA_V0_MAX_NR_CH                    8
> > > > > > > > > > > +#define HDMA_V0_CH_EN                               =
 BIT(0)
> > > > > > > > > > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > > > > > > > > > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > > > > > > > > > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > > > > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > > > > > b/include/linux/dma/edma.h index 3080747..78ce31b
> > > > > > > > > > > 100644
> > > > > > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > > > > > >       enum dw_edma_map_format mf;
> > > > > > > > > > >
> > > > > > > > > > >       struct dw_edma          *dw;
> > > > > > > > > > > +     bool                    non_ll;
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > --
> > > > > > > > > > > 1.8.3.1
> > > > > > > > > > >



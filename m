Return-Path: <dmaengine+bounces-8437-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHGWNgMScWlEcgAAu9opvQ
	(envelope-from <dmaengine+bounces-8437-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:50:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951A5AC2B
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B5CD42E6C7
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B867144A734;
	Wed, 21 Jan 2026 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TuqBYdxa"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB57321448;
	Wed, 21 Jan 2026 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014456; cv=fail; b=e7ip1xGW6WvJzrUtUrZnwZscJKWs+syZrWsxkPShPikNEhlRD0iZdjhRS63C/1s8RqCLPa1gDQZOUuTZW1VmJiMMVbuikj9GkHVPrJzax+Z+UPfcpgXqD/OgwM4m+IiDytii0Hpx5u+rv5Q6ZuxTdFljWkiBEHC1fSIVoSFF3H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014456; c=relaxed/simple;
	bh=hUB7g/Fb7Siyp0dgVPrYyvfa2kmDM/Nnbogx2/J+zTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bK5ebBeRtQ3ZOwYMJgKC3Q9zr0IuQX61UjWLNymMSmBl/y0wvw+ZZVihJc7JoJIrkQdV9FEt03mWBbSgSzec04IRrIiYxtjQH9+nn+QJj5sMFTkvFCefzKp8c0oEgQN8hWFICiWt4K/lW/ormU9bstWOBs9TbR7FOR5TEqMmJxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TuqBYdxa; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqwafg3Z3N4vieiEymo83NXZvQorv/SkrjOygQaxPO2wWoAQ+18iVxW6Bl78oAJBTTeJa8ymY1KEAONWUVeDWVLz8guLt0ZBkQTPwxrDr94PquPIXDUqdQzvwmmkesS1Mr5B+I5FKPwJRQPxafodqMRe1bU+78ozB9+w1vS2VQKnXAQjahONxmokhsIllSPPloayzKRcFLTr2ejo1niJhUmV4/Hl5eILc5VASIok+P8CeJiky9llJxSKb6YlVgZlXy8KW6YsPX8HAOFjJuFMAsDvAxpptjsjrdnaeVJa4C1tar4kDkmnwSFIEq/QXwhEGJ96l35cCdMtQz1EMYRutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thhUIgUxZsxH1ikKi3SguxzkJ1vFgIm/J0ydeCdKdlY=;
 b=as24+3nhfVVuwp2Mhpyr1xotusaQ0SAmGbCbrykzPSGBQj/kAaQHS53ZMkElRxpnd//g9vKP7a6SHNkDhmpOTs+oVDVdZyNiNMTQkgjnKhRDTWfHlkFI5TX/T31/Cn8YmHhIW8svhWXIwlOyFvLFB8jnJyEU3KJCP8Zv682tLAdfRiRdvcrcGqkJysh8cF32p0T+Q0mkWvnT+qE2iYj/DE5y8VTc3gmuJRJPlRC3yhsBVDgJD7wnmb7GuspTeToPr5RIxu5lxSwQgb3gQPxK2Fm3AVrHH8pigUhJ+67jA7+pLy8aTK8/wWYx9jSxZpiIrkSbwNQEk6Ap7QgZoJ1Whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thhUIgUxZsxH1ikKi3SguxzkJ1vFgIm/J0ydeCdKdlY=;
 b=TuqBYdxaMauGNbQSINyRYE1xSEJcDartG7VWI6pSWd47kQeLDOpgQmB6LxiyKgNF1Eo2gUMLzMCLyo9Hx3uBzdZRpsh/eNK32PoOgjrbA9qunkfERO/iQRQcVZAUmmoOj7yaYnrbgYSDg8W/REEDWv22jl4vlTtFmFk3KUYgIQ31wTJXUJj2cgfBpxjDZMZC+6wAgzYvAa5EI8a6pAbqEYBSCBE284SgYujIgDgZpSBr8ny7kl3KTw4mejYAUed1sMiqdVSlSMfB99fIz2uHxggvIWm+3iG+YnFwfa1Rvg657b430CsZQs/V+NEWKM5dCaI2ihTUCmgvoSDW+h6inQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB10326.eurprd04.prod.outlook.com (2603:10a6:150:1da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Wed, 21 Jan
 2026 16:54:11 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 16:54:11 +0000
Date: Wed, 21 Jan 2026 11:54:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <aXEEq5SvkdFYgG9z@lizhi-Precision-Tower-5810>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-2-devendra.verma@amd.com>
 <aWkT/TDoLNnGUNlG@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E8E85ABE669FD626E75D9588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5U5AoUkE2uCzaL@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120D50A18E90DEACF2B2E419589A@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120D50A18E90DEACF2B2E419589A@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: BY5PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::37) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB10326:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f62a86-0ea9-48e4-29d8-08de590db343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Svi1ZgyJPHWPt+6oE8Bkh6afS4yPhP1cmE/cxUEqLKJqzuoJbK43uw5GhUSF?=
 =?us-ascii?Q?LC9x00ipp4iV7owWM4a65jj5iPbb1LzuMomMDv2kLAzIdeywPN9LAduOhbR0?=
 =?us-ascii?Q?h5STt5/noUyCphMruGp6a82xAc8Zu+GhR4EPb1WzIYTfoJHa4ETYRz2NV1PF?=
 =?us-ascii?Q?1uVI7WQlulm41BKwhO4WBELTdikQQhVzRwpNNkLLYkFzjsSPXKDU5pqVzJJu?=
 =?us-ascii?Q?iiORVKkyg7hXQEcRIIrSFBOsAzw2JyQQybEW3GNH+yIv/7YzD8DdIVHDhOTt?=
 =?us-ascii?Q?uqd11/nIoBfsh6ear3wNYFLwIrg6dK63zS3OXoeHZGLhZs5cvWfKS0uwhPXi?=
 =?us-ascii?Q?jb9zhJf2E0CLUDM8ipemkc59X3EZpnDbQZn0CVaQFemp4fn3GJztTiyV+RyI?=
 =?us-ascii?Q?n5w4mPlgRqbn4arHlk9O8ICdrxeV8coZjpTMfUow5jTRjOQsTNKKelJM/yIr?=
 =?us-ascii?Q?z6FUIL6LY1lrTN8qJwm8XYRx/Mn3QacV4tkN8Qwr7OFeYtlgTclm7VlMxtHF?=
 =?us-ascii?Q?qTXwihDt+wd6MBdbE7WuQMmBIA0lv58C2Mem9z4RTSifa/0SQ/uTLe+W08Zm?=
 =?us-ascii?Q?NQLTkU5bMJzLnX3jO7uLKU3UmcJtieLZajekDpqEpCtq36ZlwE+hnZ0DkrYy?=
 =?us-ascii?Q?wjUOIjhMWV3AOtl1o+FsY+Nnzahg+LtZPLcD3wX2a/59UdtUd4jemcULjuLl?=
 =?us-ascii?Q?eVH8CdVtJaPfk8ALaDP9EiBD8gVKvNLlkKGdcTdmMb7gO6g9O2agJaSbE3ct?=
 =?us-ascii?Q?vljDutcVyN28ZJCWPkw6cbTNM4qR2WE4/KsyKa+hqzJ7qTAfkqC1u15OqUk2?=
 =?us-ascii?Q?Lok3yPhP59iH+bkqq8k0vicGxSBYULjrc2mJfhSM8BwhTBNj/VGr1WgvzcEX?=
 =?us-ascii?Q?lLqBXHN/154e13pE9pAfuA0dURMkvOP6iieEKZqJGAyOBuJXegjGTAid8Rif?=
 =?us-ascii?Q?WNJqOtX+qGtQ6k0fWj7n3WPlKr22Y5nLPrjFjsheol2uw5B3dnndP5KPT3wM?=
 =?us-ascii?Q?4n/43QyqhLTQBIaOmt8hEl8cujlS3QVvrr/GzkeWzXSr4QdRq42gpzlAN/V5?=
 =?us-ascii?Q?sUNqg2hQAgEj5XM7VJG4dHk4yO46E3TdRF9uZnuCkpkP0xnmaR/it2aMSu5N?=
 =?us-ascii?Q?5cJ2sohV5fwuwuWNDqAyJ3gqqSD+tRkm5p3jBSsA/xdKyVAufXqG4Ld+aZFb?=
 =?us-ascii?Q?sJp5+glFUdCDbxb9pHZPYCJXkJKXHcpaYyeIglsQoqSr5M0FEe/AZWGqqC78?=
 =?us-ascii?Q?P1uh3NYwgBYEPzNjVO7ssx3tEHpwTOkGOJ8Fb16VAGAI0Q+tXBKzqrwLQPHD?=
 =?us-ascii?Q?LS8YtbB0AGZszvlcfS68FHiPPzjxy2P3AdvhDdheZCzVLJnxoachCfUV9LTF?=
 =?us-ascii?Q?3PtbyMkszS/6f9lu+A6Kxn6x2U8uu50AdgG7CHo/hj1ZD4KLqKOuTC/Y58Iy?=
 =?us-ascii?Q?ESqvKo/e0wcmYtPCFpyNhr3Cu/+uoU+XWXokaO/ZvqxOUVDpsSThipc2RNnj?=
 =?us-ascii?Q?rGEMM+o+uWJ7ngdGn8wxbq+7Y1GwUu94eHEd9qLSnn8Cft2BmXZczSXT/STU?=
 =?us-ascii?Q?g/YDPUU5maSnTUczo1wGc46RGcBrRNP/CMVIB3GqAzIGMlsF+o0qEzG1nIz1?=
 =?us-ascii?Q?9F4yFeWwhBFhwx13mo9hq2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R0s5ElV6KP/Q7BmpW7Kz3zvJOKCYAO3RzXh3T0NPaREPyemKB4ktfy/Fw8r0?=
 =?us-ascii?Q?A6nm5yaRmm35hm4R7VtqLKeEEQCIAV8RRyv7udegVBwtLI1nl3XAvLJjHgsx?=
 =?us-ascii?Q?OuoZDPyI+FJ5PjdPlwXQtn3Qhe/nXPg1z8fCfMx0mAsb4YirjQ7xwNlDMVDn?=
 =?us-ascii?Q?5aT4ZIsuRmUbapAr2tBeXiSaeL8OFWY8WpmRjlCUnI9f1SG9ahNpFyLpUfPf?=
 =?us-ascii?Q?bIUnnd3Dg1ccYtHZVyCIJpjrdbuTfW4useM87p/J2mBKYj6IvoqFEssF37QY?=
 =?us-ascii?Q?y18ZLJzJbYMo9/b9e53QDHBY4NhOt57rTayt9N85+gj4Xzaxv+vJ09Py1Px8?=
 =?us-ascii?Q?v1p7J4Ma7K7D4vMF/yRIkT8WlaiTj8g7Wd6RkTibNb5LmQjxhJ4kQOmncJMa?=
 =?us-ascii?Q?Qiu1tByNbUH7RHUfiAdpyRNwv15VkYM69O9AFGwX3MqcVD0ayxez4Wq8UodW?=
 =?us-ascii?Q?10DsMFtw8k02S+tb55lO2+KbJ/Uqm7IfquMFar8VDOpPltg5vDwlLgrcbJ7K?=
 =?us-ascii?Q?nLG87hxA06gbk2rFylBMkbKf6AaltzQ6H/lwPZfa5W4sKjviHx8p4z91XDJG?=
 =?us-ascii?Q?YC8X+Px8AYaaZFR8bmncqryR6/1ilCP2VxteatnKmcGm6imNp2XBOQZ3ueYc?=
 =?us-ascii?Q?Vl23VDa2cDK9iMKgw1gCxJAUsz54uUDL1OLXQ8UApF/3ieYVu4dSAOdweLO/?=
 =?us-ascii?Q?SSJOD1tZwAbukShbzm+8ukszoE2Ecq57ZJajP1C3MRXoUmeowUvXIxd+QJSg?=
 =?us-ascii?Q?xGcK1PJeKas9R4GXTnJv+4hmYQMLTC8skY27l6FBVPji7xx1AGn8OCFQNpUe?=
 =?us-ascii?Q?S9qB0GH7q2vptK8l0RT7r6MfBjy6NLJ+gpp+ySp64MTLqexGyHcAuHOw9zIK?=
 =?us-ascii?Q?vvrNOBHOvk1Jmv8aTcaYY4l5HUz/9nWZ87iX9GuS5eZl4kpfL26aRSoCD775?=
 =?us-ascii?Q?jcLRwzn+kuSDHf6WxfDKLdbJsx4SWexlcU5C+PVf3aDL8VLEurXUFZL1er5G?=
 =?us-ascii?Q?04tPyT9hOmQaULK9KykQwEUcMLPGt34oUXS6YQph/w0QlGdnaM7NtdXScCWA?=
 =?us-ascii?Q?r8TFK1e3tX+3zY4jz7qNURw53hEFuGVg2axlZzdm0md63iGO4RFM8cjFYQKu?=
 =?us-ascii?Q?Bhx3WjGhq/sNkcqKaEFf/XTYxbt194uPgtFsmxqjou1LJ2sQ2o7fOOIRqSxG?=
 =?us-ascii?Q?g3uCjJEJ0KfRD1xJ42F6E1/aqh3/Iaa2nJUUB9QRY2/atDitB12l8YAsAN0/?=
 =?us-ascii?Q?dqc9Wl+ALWvgLk1qN4QcRH6T2Jgw1ajnXB2Hq6tcQtI7gqRmmKbioiWn6Hz4?=
 =?us-ascii?Q?oLo+4hDo9AMOmBgSsZ/VIJrF3K+N3mnLC9ryUSh6qLLStFPwqM0hGE1KG39c?=
 =?us-ascii?Q?SlLDUm46zt3qFQ0xjRl1yU3FFFEMpTYzFqAvrGz+bdJhOlqtn701kO6VttI/?=
 =?us-ascii?Q?Y8ExBQqn2GoGmA0LnpGw4dANKWRXoobmIk6ZhnDQeD688fiIUwNRYb+goc/y?=
 =?us-ascii?Q?BtFzlCQ/Yti9Vhv6nT4/dZIlPyjcFP9NGIiaQjOxVJRPtUA+8GF2iSmxM5aT?=
 =?us-ascii?Q?g1sHYm+IXbzgYWx6zmwiJgeZITiuVJEDEoimT+LGA5psvJZbY7xCbDc29EEG?=
 =?us-ascii?Q?E6m6RjkohhnqG0APVJSSmha3qteLS5NsU8nJp3RTDeH1Iz0AEZCt2blKSSI6?=
 =?us-ascii?Q?LQXJPFHVKiZ3Pht0JK+b/NySfyywuwcMgxsnAiQKbDMjDTuVL6dPj4WlfFNs?=
 =?us-ascii?Q?yqtLrBlOPg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f62a86-0ea9-48e4-29d8-08de590db343
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:54:11.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AD2Y+X1TZelVZshWhdbitqoCO5B+I0POp3xfKv3n3MKM0s+1lipZ0CmhrnUe2l2ugA2pUY2ERXeM3kNwGPAkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10326
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8437-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 0951A5AC2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:36:51AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Monday, January 19, 2026 9:30 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> > Support
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Jan 19, 2026 at 09:09:11AM +0000, Verma, Devendra wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi Frank
> > >
> > > Please check my comments inline.
> > >
> > > Regards,
> > > Devendra
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <Frank.li@nxp.com>
> > > > Sent: Thursday, January 15, 2026 9:51 PM
> > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB
> > Endpoint
> > > > Support
> > > >
> > > > Caution: This message originated from an External Source. Use proper
> > > > caution when opening attachments, clicking links, or responding.
> > > >
> > > >
> > > > On Fri, Jan 09, 2026 at 05:33:53PM +0530, Devendra K Verma wrote:
> > > > > AMD MDB PCIe endpoint support. For AMD specific support added the
> > > > > following
> > > > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > > > >   - AMD MDB specific driver data
> > > > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > > > >     base address.
> > > > >
> > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > ---
> > > > > Changes in v8:
> > > > > Changed the contant names to includer product vendor.
> > > > > Moved the vendor specific code to vendor specific functions.
> > > > >
> > > > > Changes in v7:
> > > > > Introduced vendor specific functions to retrieve the vsec data.
> > > > >
> > > > > Changes in v6:
> > > > > Included "sizes.h" header and used the appropriate definitions
> > > > > instead of constants.
> > > > >
> > > > > Changes in v5:
> > > > > Added the definitions for Xilinx specific VSEC header id,
> > > > > revision, and register offsets.
> > > > > Corrected the error type when no physical offset found for device
> > > > > side memory.
> > > > > Corrected the order of variables.
> > > > >
> > > > > Changes in v4:
> > > > > Configured 8 read and 8 write channels for Xilinx vendor Added
> > > > > checks to validate vendor ID for vendor specific vsec id.
> > > > > Added Xilinx specific vendor id for vsec specific to Xilinx Added
> > > > > the LL and data region offsets, size as input params to function
> > > > > dw_edma_set_chan_region_offset().
> > > > > Moved the LL and data region offsets assignment to function for
> > > > > Xilinx specific case.
> > > > > Corrected comments.
> > > > >
> > > > > Changes in v3:
> > > > > Corrected a typo when assigning AMD (Xilinx) vsec id macro and
> > > > > condition check.
> > > > >
> > > > > Changes in v2:
> > > > > Reverted the devmem_phys_off type to u64.
> > > > > Renamed the function appropriately to suit the functionality for
> > > > > setting the LL & data region offsets.
> > > > >
> > > > > Changes in v1:
> > > > > Removed the pci device id from pci_ids.h file.
> > > > > Added the vendor id macro as per the suggested method.
> > > > > Changed the type of the newly added devmem_phys_off variable.
> > > > > Added to logic to assign offsets for LL and data region blocks in
> > > > > case more number of channels are enabled than given in
> > amd_mdb_data struct.
> > > > > ---
> > > > >  drivers/dma/dw-edma/dw-edma-pcie.c | 192
> > > > > ++++++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 178 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > index 3371e0a7..2efd149 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > @@ -14,14 +14,35 @@
> > > > >  #include <linux/pci-epf.h>
> > > > >  #include <linux/msi.h>
> > > > >  #include <linux/bitfield.h>
> > > > > +#include <linux/sizes.h>
> > > > >
> > > > >  #include "dw-edma-core.h"
> > > > >
> > > > > -#define DW_PCIE_VSEC_DMA_ID                  0x6
> > > > > -#define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> > > > > -#define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> > > > > -#define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> > > > > -#define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
> > > > > +/* Synopsys */
> > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID         0x6
> > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR                GENMASK(10,
> > 8)
> > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP                GENMASK(2, 0)
> > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH              GENMASK(9,
> > 0)
> > > > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH              GENMASK(25,
> > 16)
> > > >
> > > > Sorry, jump into at v8.
> > > > According to my understand 'DW' means 'Synopsys'.
> > > >
> > >
> > > Yes, DW means Designware representing Synopsys here.
> > > For the sake of clarity, a distinction was required to separate the
> > > names of macros having the similar purpose for other IP, Xilinx in
> > > this case. Otherwise, it is causing confusion which macros to use for
> > > which vendor. This also helps in future if any of the vendors try to
> > > retrieve a new or different VSEC IDs then all they need is to define macros
> > which clearly show the association with the vendor, thus eliminating the
> > confusion.
> >
> > If want to reuse the driver, driver owner take reponsiblity to find the
> > difference.
> >
> > If define a whole set of register, the reader is hard to find real difference.
> >
>
> It is not regarding the register set rather VSEC capability which can differ
> in the purpose even for the similar IPs. As is the current case where one
> VSEC ID serves the similar purpose for both the IPs while the VSEC ID = 0x20
> differs in meaning for Synopsys and Xilinx thus I think it is OK to define new
> macros as long as they do not create confusion.

But need put rename existing macro to new patches. And I think
use XILINX_PCIE_MDB_* should be enough without renaming. Everyone know
DW is SYNOPSYS.

>
> > >
> > > > > +
> > > > > +/* AMD MDB (Xilinx) specific defines */
> > > > > +#define PCI_DEVICE_ID_XILINX_B054            0xb054
> > > > > +
> > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> > > > > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR              GENMASK(10,
> > 8)
> > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP              GENMASK(2,
> > 0)
> > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH    GENMASK(9, 0)
> > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH    GENMASK(25,
> > 16)
> > > >
> > > > These defination is the same. Need redefine again
> > > >
> > >
...
> > >
> > > As explained above, the name change is required to avoid confusion.
> > > The trigger to have the separate names for each IP is the inclusion of
> > > Xilinx IP that is why no separate patch is created.
> >
> > Separate patch renmae macro only. Reviewer can simple bypass this typo
> > trivial patch.
> >
> > Then add new one.
> >
> > Actually, Needn't rename at all.  You can directly use XLINNK_PCIE_*
> >
> > Frank
>
> Please check the discussion on previous versions of the same patch series.

It'd better you put link here to support your purposal.

> We have this patch as the outcome of those discussions.
> Other reviewing members felt it that keeping the name similar for the
> VSEC ID having similar purpose for two different IPs was causing the confusion
> that is why it was agreed upon the separate out the naming as per the
> vendor-name of VSEC ID. Regarding the separate patch, the reason is introduction
> of the new IP which mostly supports the similar functionality except in case of VSEC IDs
> that's why the name separation became part of these patches. It sets the context for
> changing the name of the existing macros.

If put trivial big part to new patch to reduce, it will reduce review
efforts.

Frank

>
> > >
> > > > >
> > > > >       pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > > >       off = val;
> > > > > @@ -157,6 +237,67 @@ static void
> > > > dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > > > >       pdata->rg.off = off;
> > > > >  }
> > > > >
> > > > > +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > > +                                          struct
> > > > > +dw_edma_pcie_data
> > > > > +*pdata) {
> > > > > +     u32 val, map;
> > > > > +     u16 vsec;
> > > > > +     u64 off;
> > > > > +
> > > > > +     pdata->devmem_phys_off =
> > DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > > > > +
> > > > > +     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > > +                                     DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> > > > > +     if (!vsec)
> > > > > +             return;
> > > > > +
> > > > > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > > > > +     if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
> > > > > +         PCI_VNDR_HEADER_LEN(val) != 0x18)
> > > > > +             return;
> > > > > +
> > > > > +     pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended
> > > > > + Capability
> > > > DMA\n");
> > > > > +     pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > > > +     map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > > > > +     if (map != EDMA_MF_EDMA_LEGACY &&
> > > > > +         map != EDMA_MF_EDMA_UNROLL &&
> > > > > +         map != EDMA_MF_HDMA_COMPAT &&
> > > > > +         map != EDMA_MF_HDMA_NATIVE)
> > > > > +             return;
> > > > > +
> > > > > +     pdata->mf = map;
> > > > > +     pdata->rg.bar =
> > FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR,
> > > > val);
> > > > > +
> > > > > +     pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > > +     pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
> > > > > +
> > > > > + FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH,
> > > > val));
> > > > > +     pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
> > > > > +
> > > > > + FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> > > > > +
> > > > > +     pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > > > +     off = val;
> > > > > +     pci_read_config_dword(pdev, vsec + 0x10, &val);
> > > > > +     off <<= 32;
> > > > > +     off |= val;
> > > > > +     pdata->rg.off = off;
> > > > > +
> > > > > +     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
> > > > > +     if (!vsec)
> > > > > +             return;
> > > > > +
> > > > > +     pci_read_config_dword(pdev,
> > > > > +                           vsec +
> > DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> > > > > +                           &val);
> > > > > +     off = val;
> > > > > +     pci_read_config_dword(pdev,
> > > > > +                           vsec +
> > DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> > > > > +                           &val);
> > > > > +     off <<= 32;
> > > > > +     off |= val;
> > > > > +     pdata->devmem_phys_off = off; }
> > > > > +
> > > > >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > >                             const struct pci_device_id *pid)  { @@
> > > > > -184,7 +325,28 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > > > >        * Tries to find if exists a PCIe Vendor-Specific Extended Capability
> > > > >        * for the DMA, if one exists, then reconfigures it.
> > > > >        */
> > > > > -     dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> > > > > +     dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> > > > > +     dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> > > > > +
> > > > > +     if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> > > >
> > > > dw_edma_pcie_get_xilinx_dma_data() should be here.
> > > >
> > > > Frank
> > >
> > > Yes, this is good suggestion. Thanks!
> > >
> > > > > +             /*
> > > > > +              * There is no valid address found for the LL memory
> > > > > +              * space on the device side.
> > > > > +              */
> > > > > +             if (vsec_data->devmem_phys_off ==
> > > > DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > > > +                     return -ENOMEM;
> > > > > +
> > > > > +             /*
> > > > > +              * Configure the channel LL and data blocks if number of
> > > > > +              * channels enabled in VSEC capability are more than the
> > > > > +              * channels configured in xilinx_mdb_data.
> > > > > +              */
> > > > > +             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > > > +                                            DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> > > > > +                                            DW_PCIE_XILINX_MDB_LL_SIZE,
> > > > > +                                            DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> > > > > +                                            DW_PCIE_XILINX_MDB_DT_SIZE);
> > > > > +     }
> > > > >
> > > > >       /* Mapping PCI BAR regions */
> > > > >       mask = BIT(vsec_data->rg.bar); @@ -367,6 +529,8 @@ static
> > > > > void dw_edma_pcie_remove(struct pci_dev
> > > > > *pdev)
> > > > >
> > > > >  static const struct pci_device_id dw_edma_pcie_id_table[] = {
> > > > >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > > > > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > > > > +       (kernel_ulong_t)&xilinx_mdb_data },
> > > > >       { }
> > > > >  };
> > > > >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > > > > --
> > > > > 1.8.3.1
> > > > >


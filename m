Return-Path: <dmaengine+bounces-8438-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOTuN2IWcWmodQAAu9opvQ
	(envelope-from <dmaengine+bounces-8438-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 19:09:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E75B0E2
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 19:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A06DAB62C83
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5813F23BA;
	Wed, 21 Jan 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bsn6h/Xp"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADF2D8DDD;
	Wed, 21 Jan 2026 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015944; cv=fail; b=KxsJsx0vwL36ry80d+BrWCiwScUvGr7wo5wP6JAXOL+Ix7EPHjb+jn9Dd9rFVGqD4TYowd8ZQJVshKsEHLL9ZDeA5n8zrZj1A4b9EIdOJbZdf0DTnuIPF8N33e+ncCHsKbvEMmobI6M29egboBimQlHVNK+ff+TyrNtF3UJTfQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015944; c=relaxed/simple;
	bh=qonibjR/QUcqECdAYAkldnOELGylhbSewRM9CoTqqoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ofSaK1IU8He7QfBn3KcGIO5XNEf/9DUhQiE3mmOsv68sUc9vgmdkv6nr4gsIxhCHdHWegqRcwU5ge3P3b0TfAYL0rQosmd7BLxSctEM/qQYpP7lX6VPrY51Y6ltBgcxzwZzjVWU2K3k0JksB6o/cPgET7YD1IubQKRjztWAqTm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bsn6h/Xp; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls+LqkHfrgDlHwHsnh0ku8bUOgTigXQGkg6jMStTGW/8xTxPPK5qmKvNUdEQSHyGE+lQfQFS4fmyeQh6b35gOKyJKFF2VRsTh47g8TDPR5J1nuS51/bIZhkBDZggtUa/Sv3u0yrfE9FWo3Hg04+gzfbVS8nOhXtBUoHz9yhHyFPwkDz4CDTIcpVCctjFleV+iZBEjgmRIbu7+AYoibqMo8mAbouhr7F+9WXtW+stXX9UlUlgqCmONYMaClnLAxDta2zsDqGYPk/8jR6ynwPgLc8svHtgurBTpnXMKFkfhR/UNFEbpOLmFIBAzWCIiOTcPDVpAadvcnTKzlC8GaSgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amDzJemzHhIpTcbOAS8GuhYZd6waGjjMtXzc5jYbb/U=;
 b=PTLlI0QTdnlcICGvKmc1o6NMsIMm6ViEOSCageqZYQhVzBzCiMW7+dEHOtMEONa22s4HZoaURRl7rnMeZqVQbrraJ2lmxe0XTDiT4IiVvyHNpWG057rVlZdciofyaNdBuU97JW/ACWccx9Djrp7sISRi+9v8PBYX7m1I4fRVLptgFlPdnvSB4x8cLCnnu7DFqnxdta05nd7TpVBchrhJK+5XM4X6SFSMx0wzGsGIj3bQ6N+QKwIai8aOvM03FXRHDWiCb6LvWdLBKQ5cFOMFzZLoV4A+iuDx+kskAyXdNdX/oh73x0iOjgsEL1amAi1sYY5T2WGBirkJ9I0uDpQJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amDzJemzHhIpTcbOAS8GuhYZd6waGjjMtXzc5jYbb/U=;
 b=bsn6h/XpuK3LBQsaupecE5gb0RFWJqwpN3Mnp0IKnT58Zhkq8znlMh0EQQDqXy1EAx85UB61SwFlY1yUTSuQEb21utRi70NQfjKA5/aKEvo6lSLSVYfolx0FO5sAe5kN0Ech8Jwj33Z5lRD5M5SZ2Ebmd/H6TJgpqWqHPX1zC6uOD6SPEDjIrlGehT/vjHLql67w+sQo0GdaxlkxXQOUpltFQ4clNQT/wBF46tfdoer5683+ytK4clSUxmNyJe+PvNm5xXYhwzkcK/zFDARtcAxEmeMywngWDyqLJTn0yqYUG1cSiVbwum450Hvy0bQzGQr+avuzwywQofMAkBWsLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:18:58 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 17:18:58 +0000
Date: Wed, 21 Jan 2026 12:18:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aXEKeojreN06HIdF@lizhi-Precision-Tower-5810>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-3-devendra.verma@amd.com>
 <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F271FF381A78BEDCE6939589A@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120F271FF381A78BEDCE6939589A@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: BY5PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::31) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c267444-ccb6-482d-425c-08de59112976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7LguCxbIfezCkCOaXimlPRMHDnPlxUg4kTGCUOztiLK5pkjBlFqkMjOLVnhU?=
 =?us-ascii?Q?uPEAp92KTWAlUopsKg7SCys9SX2zKLZCWC0fSoR/2hdUZifGkKxWk+9XQwtV?=
 =?us-ascii?Q?63zSXfM/lY2ChbFSaVKr1mdME2lCJw23q7dz3AUsu1tVs/iAv4W9CK4e5IFg?=
 =?us-ascii?Q?ESUNwMnMYvD99Wz8x5AjJRKv4hkJ6DfzvQct1xEV6AsESAjiWrZHQ8DmbOYU?=
 =?us-ascii?Q?j1FfwY0Jdg8c9FBgA48ThJI7i3tFtC60QmOilTfWFhUmx7yZNSi+Z7Z4bewY?=
 =?us-ascii?Q?LuXDLYfZrZVEZncuET0ESpa6VDAoG2x8rlXMZBU6KFjzzWml+Q/5qXFHGsMh?=
 =?us-ascii?Q?ybSCD+dItAB4y7X2nShoiMLN0A2V2vJr6VhPCP2e+N2g6IMndDJHRw+zJOMe?=
 =?us-ascii?Q?yloJAFw4dDw7A0Jge+73utavSA2pvSuXI6c0l0H64hpVsu0eHk7JiqizINLi?=
 =?us-ascii?Q?ZkY2LbmBFcnQzQ+TwDNp+oRi0wfAjF+aQ3/hEiPMCi0ofMOQfFhcCx9M9GG7?=
 =?us-ascii?Q?skU3tTFW6KEeQe39tRhbybn+45KC09n2fSeHKpYjK4d4Jl7vo+Huyx2GwkQt?=
 =?us-ascii?Q?WTpiO+TWg/DveT+zaNGbtzoAgBtDhYoTJlEjve+WM8Kcs1r8EVJfsyym0B5E?=
 =?us-ascii?Q?/mF9EHiW7gURvBya9kwfVzEx6WFN8Ygg8fpkn2IOO08lOzy4yH91MqOzYy0m?=
 =?us-ascii?Q?tALAxt3nQ9Q09xXL5eqjxRKfUm6iHIju7qjHp0+4iOGkD3lyj6AbIvM540V6?=
 =?us-ascii?Q?61LnW4lspyM/kOmHdWeo23szXagAz6EACFncr9cmph8wVkT5m+L7RRONqNVz?=
 =?us-ascii?Q?rOiJkouR3qtPASUbJum/70hy8LiIExXk2OU+hmTIN+BjEfzdhxxuchZhC8p/?=
 =?us-ascii?Q?AILnWkJLZsjG+IuwqUasIUk/QU1L7kX8GNqCj+hk0UVfW4nBHIuq+X1dBdOC?=
 =?us-ascii?Q?+f53PWBi0fSZ5J1PTuSRnFbeZNMlG2l+kaVcA7YQw1R0/yiiXr8EoG5Z+DZb?=
 =?us-ascii?Q?F0Y/VO9TihMLBGmxDlmQMJ1RtIWrnBLb0lQj/Amnyh2qvPPhXrwjdD/SJkwD?=
 =?us-ascii?Q?DIns/bRHB1oHYTCbahaWIH9jQubqTwgI94XsUdS83oBMbkQ8viP/z7oL7Yep?=
 =?us-ascii?Q?5sKINzOAZJzwNAEMtJfQf9RgJqQz+siEhAJNS/SFK6L6+pi0xVK+VqcmB55G?=
 =?us-ascii?Q?Q+uj+owtroZ3r30vkUmLueREfJHHGqCU1SbJYmZ8Z9tbKKPq2dILtNJ8EYiK?=
 =?us-ascii?Q?NyXCfi1WAUCHMMq4uD8oq7eKCB2Yx05di1n3mFYBMticTqQ99nCizXmq2DDg?=
 =?us-ascii?Q?PzFaXe0cF0kLnIl7QpqTWjjOrBwqojFpENO+AAONDdPd9OWafOTE+8wKbgbK?=
 =?us-ascii?Q?pUYB9HJYRiWwHFZoktB91v50ixRla0Xov/5NdlhOKSHNW2Ota8IGq62L/vMp?=
 =?us-ascii?Q?Qx9AZr8FkN8aQYair/rBPl+1XIJNFB7lyZmnrDo0eBXuycz19ZmRHGzlolpR?=
 =?us-ascii?Q?PUlgSUzxQzXn234ZMyV3n4yiIsccXli+m/cyLiJ4IcTI59whoMqTGJufLlEw?=
 =?us-ascii?Q?D1I0U5ZBR0b+ibW8vzapB7FRkRP6bzhximRxWEfrWjOuH67NWKIbYvxlbEpZ?=
 =?us-ascii?Q?ikEzYiMgC6P8c7pHvl5efRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NGqMdziqoaBenkLhtmIzzJdkWwLBgu7hfC/OuX3zEYBgpGxyELIA9rSBkOVs?=
 =?us-ascii?Q?lNsWAXR2NvokZ+o0Wjq+C9lAK9YC0L3KLnK4rowp0TIcnvPJt/MN4cVE07wx?=
 =?us-ascii?Q?nqAEWlUPaF9sG2ui2ANNnjdKD3zZsJXOnmO/T+CQYMBBgGwqjRcd2boQm6GE?=
 =?us-ascii?Q?2lm/S+iEU5GDDnJwVx7L2MZ3JBupjYmuG1eSHaWZcI98WTq+SP9JPpCELWtf?=
 =?us-ascii?Q?zSQnqw2irfo5n5E6Nr2mAzqIaLH6cfxHR11gqgJ0t75T7IgHMfFwlJY1yfTf?=
 =?us-ascii?Q?YcUITOns8rmt/xzXfQt8OLB7p+WEk7vD5ybVkWv5Ruo5o2NVByLD64uPUAuu?=
 =?us-ascii?Q?/+U4JoJqm0iXdZE8bnhom6QNV7lPLY213huG936MlNKUYUOjkt9MHAmkzVxI?=
 =?us-ascii?Q?CvZxbdEn1GMwsqGehP0lzKUhvcTdvkd3b7EXMxYxBTcESY8UFNYs20ekADOY?=
 =?us-ascii?Q?EFTlBVOY5znGTOi3TSZLTSZB03ZSXt4OC67w+WK/RbRtcT/THxFYnx5BwRZg?=
 =?us-ascii?Q?XKf6bRqcHyB7fqVpMJ23Xbc3U1aP3khbvPI4UEo+shSGk18Mzs0V5DjUtC1A?=
 =?us-ascii?Q?aFUWDkmRiufG11zwzBZ6s/dZhG2w4zW9XSWHqLjFcbgKqyL1tzzMX8aGN51r?=
 =?us-ascii?Q?C6p03FluiVaQEtU5bv6WpY7rV+pq6EEyNbZg+VXNPinWp+PCwZzk9Ga7hRP0?=
 =?us-ascii?Q?Kf1QoMOLldh0qXJi/Xe6aR9KH5cZ0Gc/VvHDEcBIJEQgZh+Y+ZWczwEZ1pYM?=
 =?us-ascii?Q?DY1YCHare8oXvVWdxfwBo0D15rE8/IaB/Ve39H7X5AGJqBnQ7IM7ku3ah6FM?=
 =?us-ascii?Q?2ZsENinz6UgXJqSAH+DmkM8rX3MH//KW0c3Ub8GW14372j8rDUWr9Xm8seGB?=
 =?us-ascii?Q?yOrC29xmvcmfK+bPBhVi4c+1d9X/Wkaw9qD/hHtMMlnNF25aN8TyE0pA1weM?=
 =?us-ascii?Q?o0O05DOr4UiTNUXPOyO/RjszQWKIbJIbstBG5GK+5IJdsX2s+iUa6UW/SwCL?=
 =?us-ascii?Q?aTLjdQbSniuc9LD9UNWgVgDXcqTxFl0/RaLU26xeC1Q3rt+7b5ncNDhQ1H+h?=
 =?us-ascii?Q?1039WufzA6dddeuJDqg/QIOx0yeIBU3ldwKg28gBEUUYHV7EnAyCdaY8gDcw?=
 =?us-ascii?Q?XyiAbQrl5vqa1Txm+p7ZVh5kPo3RpGHSK6rBBa+c+Zdwgl2chx4ULJz5uE+9?=
 =?us-ascii?Q?JmVYmrmFCxC7WizHZofhOVQ8x6MOLMPxLx7Jx+TZ32fpC+WPIbqJnFYwBSqO?=
 =?us-ascii?Q?u7orDEqe4v7tpeYpFR2mgdgyCseE0ZjTKTMFK4RNgUgJm5qJ/KtBMuqUi37p?=
 =?us-ascii?Q?W3FzocsLoak2+NMwyeGBtl+M1PZvnRlWbLQHHtBkfEbCoqPnnGn+kbRsbq/L?=
 =?us-ascii?Q?ByAuAiQ16Rmj+YvmrxWDF6y6RiVAu/gRqtd0Q8L7jABcpRds4ogILItOPWi4?=
 =?us-ascii?Q?GKItvNR5wnNcTbvVTdJuN24LqkVHlarrnjIx8Y+sGjGAwGtPTJrEW5LlI1q7?=
 =?us-ascii?Q?KrGjDv8d2QmB0C4Joc3jVQJFfFhpR9RAyG8iuRb81v7lxZijkQ2G38a7vxeW?=
 =?us-ascii?Q?wW6DjzIIi6eXrCrbUPGtsZng/lWYrG27MW7vXAJ6bt9vLJDl3NLSM46JwGYV?=
 =?us-ascii?Q?2k8fwb71hyWAYoDcEOQw20xZ8Z8z4aoWHhb6jjGU2gxJ7ylTvp2GyeJEu4Iw?=
 =?us-ascii?Q?r3yP2xu5cPLQbhLTV6LEJToXR5p3AV3XcSZaWA+fovpDgxy/Kfbr6swT2ZVQ?=
 =?us-ascii?Q?4ZHFgdzdug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c267444-ccb6-482d-425c-08de59112976
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:18:58.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WM6MuHj9bUQXlDua+VMBjHAcKSwjhwHeXx4QJq97/57l0CDHXXXnIIs9HPaTIKIWMRE0QIbzte+bg9vERjI21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8438-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amd.com:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 286E75B0E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:36:10AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Monday, January 19, 2026 9:15 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Jan 19, 2026 at 09:09:17AM +0000, Verma, Devendra wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi Frank
> > >
> > > Please check my response inline.
> > >
> > > Regards,
> > > Devendra
> > > > -----Original Message-----
> > > > From: Frank Li <Frank.li@nxp.com>
> > > > Sent: Thursday, January 15, 2026 10:07 PM
> > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
> > > >
> > > > Caution: This message originated from an External Source. Use proper
> > > > caution when opening attachments, clicking links, or responding.
> > > >
> > > >
> > > > On Fri, Jan 09, 2026 at 05:33:54PM +0530, Devendra K Verma wrote:
> > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > > The current code does not have the mechanisms to enable the DMA
> > > > > transactions using the non-LL mode. The following two cases are
> > > > > added with this patch:
> > > > > - For the AMD (Xilinx) only, when a valid physical base address of
> > > > >   the device side DDR is not configured, then the IP can still be
> > > > >   used in non-LL mode. For all the channels DMA transactions will
> > > >
> > > > If DDR have not configured, where DATA send to in device side by
> > > > non-LL mode.
> > > >
> > >
> > > The DDR base address in the VSEC capability is used for driving the
> > > DMA transfers when used in the LL mode. The DDR is configured and
> > > present all the time but the DMA PCIe driver uses this DDR base
> > > address (physical address) to configure the LLP address.
> > >
> > > In the scenario, where this DDR base address in VSEC capability is not
> > > configured then the current controller cannot be used as the default
> > > mode supported is LL mode only. In order to make the controller usable
> > > non-LL mode is being added which just needs SAR, DAR, XFERLEN and
> > > control register to initiate the transfer. So, the DDR is always
> > > present, but the DMA PCIe driver need to know the DDR base physical
> > > address to make the transfer. This is useful in scenarios where the memory
> > allocated for LL can be used for DMA transactions as well.
> >
> > Do you means use DMA transfer LL's context?
> >
>
> Yes, the device side memory reserved for the link list to store the descriptors,
> accessed by the host via BAR_2 in this driver code.
>
> > >
> > > > >   be using the non-LL mode only. This, the default non-LL mode,
> > > > >   is not applicable for Synopsys IP with the current code addition.
> > > > >
> > > > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> > > > >   and if user wants to use non-LL mode then user can do so via
> > > > >   configuring the peripheral_config param of dma_slave_config.
> > > > >
> > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > ---
> > > > > Changes in v8
> > > > >   Cosmetic change related to comment and code.
> > > > >
> > > > > Changes in v7
> > > > >   No change
> > > > >
> > > > > Changes in v6
> > > > >   Gave definition to bits used for channel configuration.
> > > > >   Removed the comment related to doorbell.
> > > > >
> > > > > Changes in v5
> > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> > > > >   Comments follow the 80-column guideline.
> > > > >
> > > > > Changes in v4
> > > > >   No change
> > > > >
> > > > > Changes in v3
> > > > >   No change
> > > > >
> > > > > Changes in v2
> > > > >   Reverted the function return type to u64 for
> > > > >   dw_edma_get_phys_addr().
> > > > >
> > > > > Changes in v1
> > > > >   Changed the function return type for dw_edma_get_phys_addr().
> > > > >   Corrected the typo raised in review.
> > > > > ---
> > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 42
> > +++++++++++++++++++++---
> > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46 ++++++++++++++++++--
> > ------
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > > > ++++++++++++++++++++++++++++++++++-
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > > >
> > > > edma-v0-core.c have not update, if don't support, at least need
> > > > return failure at dw_edma_device_config() when backend is eDMA.
> > > >
> > > > >  include/linux/dma/edma.h              |  1 +
> > > > >  6 files changed, 132 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > index b43255f..d37112b 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > @@ -223,8 +223,32 @@ static int dw_edma_device_config(struct
> > > > dma_chan *dchan,
> > > > >                                struct dma_slave_config *config)  {
> > > > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > > > +     int non_ll = 0;
> > > > > +
> > > > > +     if (config->peripheral_config &&
> > > > > +         config->peripheral_size != sizeof(int)) {
> > > > > +             dev_err(dchan->device->dev,
> > > > > +                     "config param peripheral size mismatch\n");
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > >
> > > > >       memcpy(&chan->config, config, sizeof(*config));
> > > > > +
> > > > > +     /*
> > > > > +      * When there is no valid LLP base address available then the default
> > > > > +      * DMA ops will use the non-LL mode.
> > > > > +      *
> > > > > +      * Cases where LL mode is enabled and client wants to use the non-LL
> > > > > +      * mode then also client can do so via providing the peripheral_config
> > > > > +      * param.
> > > > > +      */
> > > > > +     if (config->peripheral_config)
> > > > > +             non_ll = *(int *)config->peripheral_config;
> > > > > +
> > > > > +     chan->non_ll = false;
> > > > > +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
> > > > > +             chan->non_ll = true;
> > > > > +
> > > > >       chan->configured = true;
> > > > >
> > > > >       return 0;
> > > > > @@ -353,7 +377,7 @@ static void
> > > > > dw_edma_device_issue_pending(struct
> > > > dma_chan *dchan)
> > > > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
> > > > >       enum dma_transfer_direction dir = xfer->direction;
> > > > >       struct scatterlist *sg = NULL;
> > > > > -     struct dw_edma_chunk *chunk;
> > > > > +     struct dw_edma_chunk *chunk = NULL;
> > > > >       struct dw_edma_burst *burst;
> > > > >       struct dw_edma_desc *desc;
> > > > >       u64 src_addr, dst_addr;
> > > > > @@ -419,9 +443,11 @@ static void
> > > > > dw_edma_device_issue_pending(struct
> > > > dma_chan *dchan)
> > > > >       if (unlikely(!desc))
> > > > >               goto err_alloc;
> > > > >
> > > > > -     chunk = dw_edma_alloc_chunk(desc);
> > > > > -     if (unlikely(!chunk))
> > > > > -             goto err_alloc;
> > > > > +     if (!chan->non_ll) {
> > > > > +             chunk = dw_edma_alloc_chunk(desc);
> > > > > +             if (unlikely(!chunk))
> > > > > +                     goto err_alloc;
> > > > > +     }
> > > >
> > > > non_ll is the same as ll_max = 1. (or 2, there are link back entry).
> > > >
> > > > If you set ll_max = 1, needn't change this code.
> > > >
> > >
> > > The ll_max is defined for the session till the driver is loaded in the kernel.
> > > This code also enables the non-LL mode dynamically upon input from the
> > > DMA client. In this scenario, touching ll_max would not be a good idea
> > > as the ll_max controls the LL entries for all the DMA channels not
> > > just for a single DMA transaction.
> >
> > You can use new variable, such as ll_avail.
> >
>
> In order to separate out the execution paths a new meaningful variable "non_ll"
> is used. The variable "non_ll" alone is sufficient. Using another variable
> along side "non_ll" for the similar purpose may not have any added advantage.

ll_avail can help debug/fine tune how much impact preformance by adjust
ll length. And it make code logic clean and consistent. also ll_avail can
help test corner case when ll item small. Normall case it is hard to reach
ll_max.

>
> > >
> > > > >
...
> > > > > +
> > > > > + ll_block->bar);
> > > >
> > > > This change need do prepare patch, which only change
> > > > pci_bus_address() to dw_edma_get_phys_addr().
> > > >
> > >
> > > This is not clear.
> >
> > why not. only trivial add helper patch, which help reviewer
> >
>
> I was not clear on the question you asked.
> It does not look justified when a patch is raised alone just to replace this function.
> The function change is required cause the same code *can* support different IPs from
> different vendors. And, with this single change alone in the code the support for another
> IP is added. That's why it is easier to get the reason for the change in
> the function name and syntax.

Add replace pci_bus_address() with dw_edma_get_phys_addr() to make review
easily and get ack for such replacement patches.

two patches
patch1, just replace exist pci_bus_address() with dw_edma_get_phys_addr()
patch2, add new logic in dw_edma_get_phys_addr() to support new vendor.

>
> > >
> > > > >               ll_region->paddr += ll_block->off;
> > > > >               ll_region->sz = ll_block->sz;
> > > > >
...
> > > > >
> > > > > +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk
> > > > *chunk)
> > > > > +{
> > > > > +     struct dw_edma_chan *chan = chunk->chan;
> > > > > +     struct dw_edma *dw = chan->dw;
> > > > > +     struct dw_edma_burst *child;
> > > > > +     u32 val;
> > > > > +
> > > > > +     list_for_each_entry(child, &chunk->burst->list, list) {
> > > >
> > > > why need iterated list, it doesn't support ll. Need wait for irq to start next
> > one.
> > > >
> > > > Frank
> > >
> > > Yes, this is true. The format is kept similar to LL mode.
> >
> > Just fill one. list_for_each_entry() cause confuse.
> >
> > Frank
>
> I see, we can use list_first_entry_or_null() which is dependent on giving
> the type of pointer, compared to this list_for_each_entry() looks neat and
> agnostic to the pointer type being used. Though, it can be explored further.
> Also, when the chunk is allocated, the comment clearly spells out how
> the allocation would be for the non LL mode so it is evident that each
> chunk would have single entry and with that understanding it is clear that
> loop will also be used in a similar manner, to retrieve a single entry. It is a
> similar use case as of "do {}while (0)" albeit needs a context to understand it.

I don't think so. list_for_each_entry() is miss leading to reader think it
is not only to one item in burst list, and use polling method to to finish
many burst transfer.

list_for_each_entry() {
	...
	readl_timeout()
}

Generally, EDMA is very quick, polling is much quicker than irq if data
is small.

Frank

>
> > >
> > > >
> > > > > +             SET_CH_32(dw, chan->dir, chan->id, ch_en,
> > > > > + HDMA_V0_CH_EN);
> > > > > +
> > > > > +             /* Source address */
> > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > > > > +                       lower_32_bits(child->sar));
> > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > > > > +                       upper_32_bits(child->sar));
> > > > > +
> > > > > +             /* Destination address */
> > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > > > > +                       lower_32_bits(child->dar));
> > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > > > > +                       upper_32_bits(child->dar));
> > > > > +
> > > > > +             /* Transfer size */
> > > > > +             SET_CH_32(dw, chan->dir, chan->id, transfer_size,
> > > > > + child->sz);
> > > > > +
> > > > > +             /* Interrupt setup */
> > > > > +             val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > > > > +                             HDMA_V0_STOP_INT_MASK |
> > > > > +                             HDMA_V0_ABORT_INT_MASK |
> > > > > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > > > > +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > > +
> > > > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > > > > +                     val |= HDMA_V0_REMOTE_STOP_INT_EN |
> > > > > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > > > > +             }
> > > > > +
> > > > > +             SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> > > > > +
> > > > > +             /* Channel control setup */
> > > > > +             val = GET_CH_32(dw, chan->dir, chan->id, control1);
> > > > > +             val &= ~HDMA_V0_LINKLIST_EN;
> > > > > +             SET_CH_32(dw, chan->dir, chan->id, control1, val);
> > > > > +
> > > > > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > > > +                       HDMA_V0_DOORBELL_START);
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk,
> > > > > +bool
> > > > > +first) {
> > > > > +     struct dw_edma_chan *chan = chunk->chan;
> > > > > +
> > > > > +     if (chan->non_ll)
> > > > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > > > +     else
> > > > > +             dw_hdma_v0_core_ll_start(chunk, first); }
> > > > > +
> > > > >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
> > {
> > > > >       struct dw_edma *dw = chan->dw; diff --git
> > > > > a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > index eab5fd7..7759ba9 100644
> > > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > @@ -12,6 +12,7 @@
> > > > >  #include <linux/dmaengine.h>
> > > > >
> > > > >  #define HDMA_V0_MAX_NR_CH                    8
> > > > > +#define HDMA_V0_CH_EN                                BIT(0)
> > > > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > > > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > > > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > > index 3080747..78ce31b 100644
> > > > > --- a/include/linux/dma/edma.h
> > > > > +++ b/include/linux/dma/edma.h
> > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > >       enum dw_edma_map_format mf;
> > > > >
> > > > >       struct dw_edma          *dw;
> > > > > +     bool                    non_ll;
> > > > >  };
> > > > >
> > > > >  /* Export to the platform drivers */
> > > > > --
> > > > > 1.8.3.1
> > > > >


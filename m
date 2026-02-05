Return-Path: <dmaengine+bounces-8752-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCtjMmFAhGng1wMAu9opvQ
	(envelope-from <dmaengine+bounces-8752-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 08:01:53 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E55EF35F
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 08:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35A6D300D687
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 07:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48C821D3F2;
	Thu,  5 Feb 2026 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="iO+NUP7Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021117.outbound.protection.outlook.com [52.101.125.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73206199FAC;
	Thu,  5 Feb 2026 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274909; cv=fail; b=Uv/TQEQDVNE9iMbbmEXowlidJ97N9M/h40cP/eXiwbBiE/J7zCyHDgEvR68jaHEYk/PmKZ3tZqZteS3mB8F9Exr31h/mPFz3KqNmdmXY1hz/eu39nCvEtFhAU8efvlUfOhVa6J5BeqJ0DPKSxxNGNmcFELsrTIgxGKh5ek2t53M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274909; c=relaxed/simple;
	bh=GgQas0sZ2IaMljrnVfEWz5sZHc0U+wgrDQXcQQwbZJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ou7P76WQct6C5MyMEiQ2yXjIqIdK+fXtQWv3hzzWfqTuVF2RTOYUtJDlt9odiLuT+lXRy9m9qF1kKTz3SFHJlAHPSDMFv//x+2E/QD6bYqwxCol3oaM3iPO9mALTaNbgGhgRKwQdWv5N5b5EjeteJyWqcs1VNJ1Tge0PGxgmPF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iO+NUP7Z; arc=fail smtp.client-ip=52.101.125.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3+LRXrFWSQfbFWjBXFwJacnw1ObOcCaGzXytkFukji/9ATPjs8Wh45QsPY7nYtHveD0/0jTvCjWYM1PSoE1O4NXoheJejn5c1AyLJ7Uu4gCyybNNd3Xzpmxbx7xROiSHMMq83owRm/IOZb3IHGG2Ng8bO5eyYUz2hWzzmCXo7Pk1pzAB6Vvo6ZirOKXmLRYyvjnaoDBnLZjZ3M6j7SKCQ7x/0aRLJErv9YwWkXKfYhi8jqKMhq8W0cOpCEkNq0I3sArYJHUnlxp6UCnSORyRFwctwghknSbK7h4VGwa5ws3WuWqTkGITrBLmlf+N21ufyCyqsj7b49hqlI+FKGzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHvoAfvenmodo45dZSpo6ful6QGtbDAyOH/Skaq5HhI=;
 b=O0iCfG0+NALfMeDZw50207NvuRQLRsKL0EXKSiGr64h3GfI6fwSMZehQDY6Vb8e6cJ0F/jGxVfyefSl8RluhT4gVipgOHEHtQk/L4p6qQF3Y8sqSEuuEIehBfaK2/7wVUV3MSbgICGo3yWtzzI4sKPvtluL5BCwYuRw9ZeMtBRNLBwKWmyAd2Qqvaptq40yqwj6dDoXfrpAKmjBCcILgahTAprhO+pvcaK3tsgJO9KcrI493KTu8vmiEv8cnkXrc3GoungDGjja+x4unh71wIyUeUs51o1o3KISlplas6tA4hIyTF8e0FfkNlIGPGLL4YE7TD2GWi6yRurDM3oBrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHvoAfvenmodo45dZSpo6ful6QGtbDAyOH/Skaq5HhI=;
 b=iO+NUP7ZryyNnFJbNnSJgz/DLcuc14v1Al9VcormvcdGjv7WfWum/i46AYA39aoaYheTsAm1B4ZauwGIStZdsL7HDNyTkgIYzUskf0Su4dgHUR6vO/IPHBQrCqqvNFxIb9B/rVvGGWBBF9aQOV8mtZbLH1R86ZAG9bI+0LXQzuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6456.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:41b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 07:01:47 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 07:01:47 +0000
Date: Thu, 5 Feb 2026 16:01:46 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/11] PCI: endpoint: pci-epf-test: Add smoke test for
 EPC remote resource API
Message-ID: <27zubyj3yzf2mazuq3ub3xmysizbmlpbrnozi32ha2x2cijzhl@exh23bitrsio>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-10-den@valinux.co.jp>
 <aYOf5DXQjVEpcwCE@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYOf5DXQjVEpcwCE@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fcd061-9e8c-46ce-c69e-08de64846db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nZu/oUYP+aFFz6YhCOSXL6MYB77guHCykZ17Ou3PF+AW/bxZbzeZKr5Ov2VI?=
 =?us-ascii?Q?iQ4RLN9YmIXGAYRhvOaDgm/K1GzylZK3ZoFyeOTzXc4KOYWPdWxhIKHLu14x?=
 =?us-ascii?Q?SnKEii23Ms3sBLM8KhMTrPvE3tONjQR9e/XzcEYBtXM0TEQoCxylJWF3sdM7?=
 =?us-ascii?Q?nwIq0x/yclyZGTNGKOKmsSfr5n0ArxmrWArvtXnzsOyCduLPdHPjYsQZzZ9j?=
 =?us-ascii?Q?2HLsxJDjDSevZJUO84XUS1q89TXIna1B4Sx9N1ro043nrXSWkyApdPrLTGSs?=
 =?us-ascii?Q?spfkn//Ia9IPV78mpGkC8MgXU9uSuuLed4zG/HISFMjI+6IwyFUt8b0nbQlJ?=
 =?us-ascii?Q?LMU+7WGwb0u9zMyj9zFxnhF8RWIlX3FK78Trzx3zHg9mSK7Gb3H9rgbPXbXM?=
 =?us-ascii?Q?2LZLcloNiWKJpCbrRK4fIxtohnn9PQcRMaItXD6h2e4iD2Oitg6wf2q8QihD?=
 =?us-ascii?Q?/1atWFYDdY4rPQfjkGfgLSWfaaihL7ZSHY5MyO0B8H01SqbNSbO+suyD6IVA?=
 =?us-ascii?Q?IWsm+T0SL807ALup+5R9K3/YEQv4Rn6O9xcOlr+XiVJcWAbNf8rSuzFOcnRu?=
 =?us-ascii?Q?FkMfWHU2Zf+TWXQLspW5FVH+4FuEqKqfsnD1+2YYO7E5EG55mhjRqeMs6dDr?=
 =?us-ascii?Q?ll3yncA2gYtEwmhmh+zDAP0+FhBkmeH6SaKs++u1BI8EOoGUmxRd6VBu1Iqr?=
 =?us-ascii?Q?sP088LCU6xFTwGBIqrD8nIfBZGrPBciTQq0mutxyP8mMQdvyzxY+Puu/Va+o?=
 =?us-ascii?Q?xdYqDyJ5UZRvq7v9xvgQ+nCVfjvNoPT3M13BZqRnzCp28bGwNF/1L+2fSoiA?=
 =?us-ascii?Q?htekLcSWcotvRoXL+ELjtiP9MBXToFQtDJb1Pn7ySGgeEnL1vDElcv5w+OQK?=
 =?us-ascii?Q?u3o4DwX4OHHXWIY7qK9ACyAgbpoexJ15cr7LHeEZEMDurjZZP4sr7ETDntM3?=
 =?us-ascii?Q?NW8fcdoSBjLtw9t5nxm2Y6PFN8Xciq1rC03Imef6HzM+MAsSMI//WtqnZSIk?=
 =?us-ascii?Q?nmbH2yXVJffr6Sa8GyVsjuNzYnlV9pdFtyWkCOC1O8Q2B9NPgh2t6MaOmPIw?=
 =?us-ascii?Q?OhCHncl+VPui2u9ub+fEfBwFWbTQf7rbA6y6AaydPSgrYQbZhORBpGfVcBGN?=
 =?us-ascii?Q?2C6HK+QA99+AnluZBLvU5u3/hndknccAKswLoV6AUNZWcPxsVB082AHHDQaQ?=
 =?us-ascii?Q?gx2iW84rCDgUNWltBcYbBD47joDNSOwnTYhiYa8Cc+kl2HbPAmui+2CXTJ8C?=
 =?us-ascii?Q?GbUQDq6frZEP6/oySjVaOogljJXomFJIELwH+YvD/7+JO4cBSmdW2OeYBExC?=
 =?us-ascii?Q?5DS+iu+0eC7EAJhqLGcP/ZaPVEBBYgqSz1BJ4B/Lfe7/PmV4C2qJB2thV2Zk?=
 =?us-ascii?Q?48+H4/zC+zB+bL9kI37oXQlFt7Q4Jxg8nIg/uLb53zdxjyqWcZUwlZpu20F6?=
 =?us-ascii?Q?vPQ5EeK3dqEjatVO/vBEYL0Dt8GFTU4PRYHf6xuuBJFut0P3WXAJ9ElglciX?=
 =?us-ascii?Q?zU1j368qjiIQHCH0TngZu8ulZyr0R/uLXChCEE8kHc6ZjvBSXPctbTU0laZ3?=
 =?us-ascii?Q?QqVAb+MbUsSsjJwwSCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8B+OZ4rwMwBFYI/PNSwO/YMyU51/gnnk0c9phdabNYgZVee7oWaQ3l/3wXnx?=
 =?us-ascii?Q?GOc+qklweo04A0b8PQs/mtAOFNdBpST99zQegURZAczSOSq8Bd4cuvcpGOSl?=
 =?us-ascii?Q?4RlZhCqQwbm1hXpBRh9Zjg29Q25cCRyd6NUsNqHS0md0NrfgeegbbcboG7g6?=
 =?us-ascii?Q?iI0S9ASHigP5+ez8TKSXqEFgNVnHqBVWHN7dtFGe8EJC6xo/Y64i4eN41/L1?=
 =?us-ascii?Q?zZ5aRuec2TtF0lTMGA3xO5biYoAZHsCiS+ySmddd7lV0NlKlwNwhpKO/SwPe?=
 =?us-ascii?Q?O3Qe1jxRty69iysVHZ2inehd86Oa/jzfB0bTHeM/Wfu9woBxfKgMbwMVCS68?=
 =?us-ascii?Q?yeHGiqJEiWzqBR9XsihyToOfcsA2fJF12AHEMPsZK7VmNmmobs6AAExVTbIU?=
 =?us-ascii?Q?ozhH2iEhWlnUGJVVFHqNJA/lf2Z5ZWrafcRAOpiWdWHhtInLejFd7C1n3G5Y?=
 =?us-ascii?Q?xindNDqNodj1jRPCPNJjB1zMs/dpAxl19G+JjxMyjAN2w/ou/mUTQCveNbYL?=
 =?us-ascii?Q?pn6E3P2tTKQBXCN2IKs0k59Fpduznxv1Ltbld3qDNMFsxaSPHQh1cb2OOD9v?=
 =?us-ascii?Q?LjMgyDYgl8ovYmFLeT7mLfF70KaeL/hVltkiCB6p6LzbG6YY3cEfy/8m2WZp?=
 =?us-ascii?Q?HqLGO1A95dggHwt77OXAuaczD//ENRAUevE9nRactwgUTWOqCC2/fmfhg+fp?=
 =?us-ascii?Q?wcbpDMcwk3BqC0X36ajhVkYxw+hBqb6fiTABAycwvLqcUOuXZsIHRhQpwBmY?=
 =?us-ascii?Q?FY2hZEvHVqgrhAuJqQzQclCNqhhkd2HRnSwHl9RmgnNQ0M0AH/MRYwo+AF6+?=
 =?us-ascii?Q?xgKkAPZ7CgUx7VlFSq1X7Ou8PpVsApH57NZWvjX8tLwvCgb/EYjCW8Rp9/gi?=
 =?us-ascii?Q?GzNHhGWeR0WL0j8dK8IhsL815S+M/hLuQPgHRKBNPUCEQTJe9pKOed6199a/?=
 =?us-ascii?Q?w4YLVewJE04j2Ewsn+w6pHJ/l/8kJx8FAmlpLRpxt2rOtNLkXir3ggAfegjS?=
 =?us-ascii?Q?+FPcYD8e+3/q5onv4c7zfMBGHie339/KLr7wXl8g7AoaTuRK4wwX4HUKm9SM?=
 =?us-ascii?Q?KAAVHRKWYBdH1WwQWnqxRtyyrpMVOOJZ2ImHd5pqrM0PpN16gCLLHfOwnsyy?=
 =?us-ascii?Q?kj+BT8QnSbp9d4QbysmirPchWMOtCjHoTP4n1ejCr4i99fxvdO+HKTPb4+98?=
 =?us-ascii?Q?+NXRYTsuNcx45hy5VfpxHf6WP/GJwQe6/wN2GCU6HxwWuwZsSuGwByFhHiWU?=
 =?us-ascii?Q?Xgiqbt4+IkMSjf+Ue6Lg53081MoqcOP610yVIZivda9mDy87tsrATcMMBx2+?=
 =?us-ascii?Q?dwa6ygIWgNKKJgkn6A5IQu8kbL296WfvNg6jgdBjn2Ei5QHTGrW/U8f+Ni3e?=
 =?us-ascii?Q?Va8hdMFM8tuhcA3ROnff5FYXC9nNKPTiTX4vKY7Wl3sZBrD2zscoHa+FsoTQ?=
 =?us-ascii?Q?QZ/OURSMXxl2Z572ZFRPir5SZdWN/MrxK3try8RQXZFzyvs7YPV931KqfPpC?=
 =?us-ascii?Q?eseGL5uut754MQh5hBWuHCqWiYJk7cemEszLjj5ux9Xp7rofeA07OrmxO5XF?=
 =?us-ascii?Q?81UkC34ORCceUSIj56wfWiXCSG/hL+LWQLqZvBtCjxJyPmqzd8HzGidfEkjZ?=
 =?us-ascii?Q?W2W+LTrc4H+FG6cqG0exX7J/Skp9aCn6LQ8wIhCsWbWF77pL/f0lCS3qk13s?=
 =?us-ascii?Q?LOx21m9hv48Rddua+5tAVhczA3K8BtAItn45Tyl6FPMWwvHszqQun7gEhBh4?=
 =?us-ascii?Q?xgDJSWGwQSL3Q58jgtKmtUpp4WTJnoxm5VMUN8XrqaS/AUn2eFgo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fcd061-9e8c-46ce-c69e-08de64846db3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:01:47.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0uGtgy860dW4kH7OyFbgU6ug0+qj1tQw1pYtckR8oK9dZusfZDJ+miu37qzYfiix6AbbCnElCpBre7dqdc9ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6456
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8752-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43E55EF35F
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 02:37:08PM -0500, Frank Li wrote:
> On Wed, Feb 04, 2026 at 11:54:37PM +0900, Koichiro Den wrote:
> > Add a new pci-epf-test command that exercises the newly added EPC API
> > pci_epc_get_remote_resources().
> >
> > The test is intentionally a smoke test. It verifies that the API either
> > returns -EOPNOTSUPP or a well-formed resource list (non-zero phys/size
> > and known resource types). The result is reported to the host via a
> > status bit and an interrupt, consistent with existing pci-epf-test
> > commands.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 88 +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 6952ee418622..6446a0a23865 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -35,6 +35,7 @@
> >  #define COMMAND_DISABLE_DOORBELL	BIT(7)
> >  #define COMMAND_BAR_SUBRANGE_SETUP	BIT(8)
> >  #define COMMAND_BAR_SUBRANGE_CLEAR	BIT(9)
> > +#define COMMAND_EPC_API			BIT(10)
> >
> >  #define STATUS_READ_SUCCESS		BIT(0)
> >  #define STATUS_READ_FAIL		BIT(1)
> > @@ -54,6 +55,8 @@
> >  #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
> >  #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
> >  #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
> > +#define STATUS_EPC_API_SUCCESS		BIT(18)
> > +#define STATUS_EPC_API_FAIL		BIT(19)
> >
> >  #define FLAG_USE_DMA			BIT(0)
> >
> > @@ -967,6 +970,87 @@ static void pci_epf_test_bar_subrange_clear(struct pci_epf_test *epf_test,
> >  	reg->status = cpu_to_le32(status);
> >  }
> >
> > +static void pci_epf_test_epc_api(struct pci_epf_test *epf_test,
> > +				 struct pci_epf_test_reg *reg)
> > +{
> > +	struct pci_epc_remote_resource *resources = NULL;
> > +	u32 status = le32_to_cpu(reg->status);
> > +	struct pci_epf *epf = epf_test->epf;
> > +	struct device *dev = &epf->dev;
> > +	struct pci_epc *epc = epf->epc;
> > +	int num_resources;
> > +	int ret, i;
> > +
> > +	num_resources = pci_epc_get_remote_resources(epc, epf->func_no,
> > +						     epf->vfunc_no, NULL, 0);
> > +	if (num_resources == -EOPNOTSUPP || num_resources == 0)
> > +		goto out_success;
> > +	if (num_resources < 0)
> > +		goto err;
> > +
> > +	resources = kcalloc(num_resources, sizeof(*resources), GFP_KERNEL);
> 
> use auto cleanup
> 	struct pci_epc_remote_resource *resources __free(kfree) =
> 		kcalloc(num_resources, sizeof(*resources), GFP_KERNEL);

I'll update it, thanks for pointing that out.
> 
> > +	if (!resources)
> > +		goto err;
> > +
> > +	ret = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
> > +					   resources, num_resources);
> > +	if (ret < 0) {
> > +		dev_err(dev, "EPC remote resource query failed: %d\n", ret);
> > +		goto err_free;
> > +	}
> > +	if (ret > num_resources) {
> > +		dev_err(dev, "EPC API returned %d resources (max %d)\n",
> > +			ret, num_resources);
> > +		goto err_free;
> > +	}
> > +
> > +	for (i = 0; i < ret; i++) {
> > +		struct pci_epc_remote_resource *res = &resources[i];
> > +
> > +		if (!res->phys_addr || !res->size) {
> > +			dev_err(dev,
> > +				"Invalid remote resource[%d] (type=%d phys=%pa size=%llu)\n",
> > +				i, res->type, &res->phys_addr, res->size);
> > +			goto err_free;
> > +		}
> > +
> > +		/* Guard against address overflow */
> > +		if (res->phys_addr + res->size < res->phys_addr) {
> > +			dev_err(dev,
> > +				"Remote resource[%d] overflow (phys=%pa size=%llu)\n",
> > +				i, &res->phys_addr, res->size);
> > +			goto err_free;
> > +		}
> > +
> > +		switch (res->type) {
> > +		case PCI_EPC_RR_DMA_CTRL_MMIO:
> > +			/* Generic checks above are sufficient. */
> > +			break;
> > +		case PCI_EPC_RR_DMA_CHAN_DESC:
> > +			/*
> > +			 * hw_chan_id and ep2rc are informational. No extra validation
> > +			 * beyond the generic checks above is needed.
> > +			 */
> > +			break;
> > +		default:
> > +			dev_err(dev, "Unknown remote resource type %d\n", res->type);
> > +			goto err_free;
> 
> can you call subrange to map to one of bar?

Just for the record, BAR_SUBRANGE_TEST has already landed into the tree and
excercises BAR subrange mapping end-to-end.

In my opinion, simply mapping the returned resources into BAR subranges
here would mostly duplicate the existing subrange test unless we also add
host side validation, and some resource types may be MMIO, so I'd prefer to
keep this as a smoke test. If you had a specific failure mode in mind that
is not covered by BAR_SUBRANGE_TEST, please let me know, I can try to add a
targeted check.

Thanks for the review,
Koichiro

> 
> Frank
> > +		}
> > +	}
> > +
> > +out_success:
> > +	kfree(resources);
> > +	status |= STATUS_EPC_API_SUCCESS;
> > +	reg->status = cpu_to_le32(status);
> > +	return;
> > +
> > +err_free:
> > +	kfree(resources);
> > +err:
> > +	status |= STATUS_EPC_API_FAIL;
> > +	reg->status = cpu_to_le32(status);
> > +}
> > +
> >  static void pci_epf_test_cmd_handler(struct work_struct *work)
> >  {
> >  	u32 command;
> > @@ -1030,6 +1114,10 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
> >  		pci_epf_test_bar_subrange_clear(epf_test, reg);
> >  		pci_epf_test_raise_irq(epf_test, reg);
> >  		break;
> > +	case COMMAND_EPC_API:
> > +		pci_epf_test_epc_api(epf_test, reg);
> > +		pci_epf_test_raise_irq(epf_test, reg);
> > +		break;
> >  	default:
> >  		dev_err(dev, "Invalid command 0x%x\n", command);
> >  		break;
> > --
> > 2.51.0
> >


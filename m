Return-Path: <dmaengine+bounces-8522-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFs5HMQyeGlRowEAu9opvQ
	(envelope-from <dmaengine+bounces-8522-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:36:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6288FA23
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B6C23057492
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 03:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D9130CDAF;
	Tue, 27 Jan 2026 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="O1ijcerz"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021079.outbound.protection.outlook.com [52.101.125.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7B30C639;
	Tue, 27 Jan 2026 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484892; cv=fail; b=chbIN39TuLllCUcZN6UXQCs1pi8kzWcmwTNaz48ovSX0wvw8ZXPSTPI3ruI/4TWhJHhD6JQjvl/lhU2cTUdHhpeG6AWWsQoxqhlsHvs7A6W+Uqk/lRnIrFZk3X5P9qzGJfn/xsLLmBtZRsSRLWMiW7/rWynW4DVS0Jed8bz+vLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484892; c=relaxed/simple;
	bh=3XFRvZJe7QeWL2MygptgCOjf7q0n4y/fo8zfHbyD6n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwuwsFf+tX5iRwcJkg/Dna/mI/7e1BBO/9QRgidCQrygl6Iet7ZaOFCGhwsTI4fMapxt2ajJz2tZzhmAc9fg/wni7kuy2gb9U8knpY4koCpcFfN5z05NLxcbKR2bEQQJQk6IeaW4IcUYZ7Tu4zXh1p4Z29qHjJHyKoT9Hg+nmKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=O1ijcerz; arc=fail smtp.client-ip=52.101.125.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0fONbzSl1CpZfuirrjQ3skhCzs3MQJME7k3+cZBZi1JyNx+n54RgD5ECSCd2zohSuYxJkCMkdwWENoYsZDp6cXmtR8wzO9/F7x8weVpR7D4kZOxaDYDmgFBw92xUrE0TIeZQoTs+bgoPlsofLMFG0tRd8Irrdm4yQS714dFB6UpEI42J4TOzEoRVJeGPEfWqgYyVG+5HDwivXJ52Jrn+OevGIUeWqaYnmg3ELUqrFpJX5v3i8eeTvWQPygUwripqnpvJEmEfRlVPz050YMt+0eKJDQUJT7Dzt8EYVyoVb5KH/sOJ9HKSey+1kbZwb2BrlNnsTQ+fswK+gFPWF6agA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJXYHUtxYv3WC+NfyEmIhCxgU0T4DnhMWrnH30SkZp8=;
 b=VvJwpeeNva+rJkveh4AUaucUAqSCCaOz5+hi2AulUpoir7Kx6bjGkUdoR52FZX/qBoOm8K2+cw1Mr2aKHMCjRh+TtT598fg7SMZQ8GkRHYn0uqUgKsEdDcMIcX1T98ydOHjqNVrG/fWuc5cauNnzBwJNB589bWecTwSvzpwchMiPG8YewuQDeKZmimZxQwCqRvlKU+8UWGkZ1MQPreJXMA7cgoyrfspZelTzqhjjpvKf11vFPslxctGtaHSrcbaZRGhOZ3DkRzNvChuHq9HPf4m/rRGMCbk4sa0OhFiTBVLp9SSt+xke3DyudGKxW3vUr83slYlbIz/OIGGW3MUsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJXYHUtxYv3WC+NfyEmIhCxgU0T4DnhMWrnH30SkZp8=;
 b=O1ijcerzzQq8ymvdk5vUph4AP1ahHVkqgYBQJfzPXDZ9OVakbSvovPlShNnHw6s9ZSbMO4XpQ/p3msoQsRhwrTSqyjomrwCAmycMpHZ1iz+TqNTmLjA2FoqH89oPTabQnTSKwmvW0E7rs2Jguxwjgc+9m/fm9D62ZZya6n0yRA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5626.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:34:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:34:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
Date: Tue, 27 Jan 2026 12:34:17 +0900
Message-ID: <20260127033420.3460579-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127033420.3460579-1-den@valinux.co.jp>
References: <20260127033420.3460579-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: a657b6b0-1dfa-47ab-42d5-08de5d550302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZBckcKnDAJt+Nb54T/0VseFrPjRr8L8Wjbs/ipmH2kI2w9QA6oVT8sl9Inn0?=
 =?us-ascii?Q?656SlGPHNLdNMkwT8riK/et1NM6mHq1ke8nFx03vvFjWh1af3mUHDrCZJ3Vo?=
 =?us-ascii?Q?cqqzw4Id6/DSY9BpYpMWdjiAEv9TEXH+uyWOv17a/r9hFXDXocsOoXCbL3Ra?=
 =?us-ascii?Q?G1Nh2OjxVZcEkmuaHjuIjkTkjBalzSBFYq4MUFLbnrY9i9GL+YfQ8O0V8DDT?=
 =?us-ascii?Q?NapFsalgJibX16ThrEmnEbbvTdHfUnBSagjvqQWvFqnf88UCCwIvk8cE7b6E?=
 =?us-ascii?Q?Pn7oOA3NnFMeUcMgCZNy7hyDdKXkNcS4BgGXsw6duKLgpjeue7yvVUecZ6ck?=
 =?us-ascii?Q?VNJvaBef8SvA42cRRhn4OnXTyISnrvN7qBS2QhUKnsA8eQLI2rIDELrK95At?=
 =?us-ascii?Q?ew5NseyE8xCCOzSgCLvXE53R5ku264Pj+xbw7cM/9IfMOD6Z9lQMpuYVgO91?=
 =?us-ascii?Q?4mkgvrCUhQ++qcZqfvSSdLm732CS1Fm9lIOtKBnKze8QNiSwrIw1su1hl7Qs?=
 =?us-ascii?Q?SPKXxSwnb7olIK2yS15wZx7/krdHZLWhEjMGEprV52Y9BduSWrbYxWUVfax7?=
 =?us-ascii?Q?QUoVQZmgdVQwyWhmmdv3S4dsd+UfTuBQLjH3QgWD+Qhu+1GFvIKtutcupUAM?=
 =?us-ascii?Q?XmmGw6iEH3tbJmTwzMQjiP1jWEs4AWOAAmkVvgImoE39eZ+JqSm90BNhVHFa?=
 =?us-ascii?Q?yxTMF2lWR8DcJAoBEkWfFMqqMIdDus8Hx1CaIMob83ObW2hqF8wC6vCYQsG5?=
 =?us-ascii?Q?FjpvsSAc7UChADS8DV0gG1XL2iGXZLrnltiF+EulXiBdf8UNIaAdzGRF81QS?=
 =?us-ascii?Q?WlCcNdvBtIm7xvxvCD6ux7Mllx6dWryraBJR+bB2YuHQVoW0ebYexNIB0CBk?=
 =?us-ascii?Q?XMDMMsNtqiQIAQ5h3Cvgo6oxsSoD5U08fR3Tz/viivD4593gu9ujWblzYm+i?=
 =?us-ascii?Q?bAfmBQmAHlMFs8XrFnJsbZUhfOLssa69vXOdtpg1unssuSsuTHBETu2VBTb1?=
 =?us-ascii?Q?6GyLZhvKtBTtrUFOOQmQ5wUVOHbzKI4WPOP3v+AdpC5tuETNc6ViHoY45iHr?=
 =?us-ascii?Q?42Sxl9PAc1pZpr0R0xS4BK2VrzcB+sKODV6FJe+dvpioGzNT37EJjtsUKgMz?=
 =?us-ascii?Q?bqAj2rNvbXN1HkbEbKEXJ8MyHUVQNPr0Fzx4edDTkMJsQURqBi6ZblZH1rwa?=
 =?us-ascii?Q?QKrHT/6Lvx7Xk4C2liKOkJ9BtKEExCHEvzNbpC5vPdE7ZRuztys1qbcewSxl?=
 =?us-ascii?Q?9a36e4bqIsy++ypXRVcd8lPTpve4QQcw2SAMy5WpIeGtBxn+ndzKwjsqVnol?=
 =?us-ascii?Q?wd298o3VVpHmcBxOiVuPHhLxAIdKLJnvj5T1aKiEa5vo0WpMluo8U/ZnVt2g?=
 =?us-ascii?Q?kezKjf6B3nbjL4yxKoNw5nrrKZfAtz8DsFILk0eZnk70rIMHbsMLk0izp7Ey?=
 =?us-ascii?Q?s1xkkhyp7yCBs3cM92M+DD7AZKJat1SRVHieAYkBMXq49hWRhKdingCsjZSL?=
 =?us-ascii?Q?kh4rD6U+hcE51bulCeyB5BWqSpCp/m/xFIHnuTcn/3VOntpflMiqu84oMzs2?=
 =?us-ascii?Q?yKBs2Cv18yIzliFzGNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXwXq93GL9eALciNW0NmMhHNeez3xpGGr1ewvgU/MFvUMi29XvIdTMHkEkzQ?=
 =?us-ascii?Q?OwNoA6g3tbG5EaxZAgp4UbeWT1F/wvMUNwfgeIvM/S5GR96ns5QUUj6G0jjI?=
 =?us-ascii?Q?meK63wtk0lrc5rxKwj2z4U4syhav5nAwZto2FHqbW4RyYZgwEE+xtLUnxqpJ?=
 =?us-ascii?Q?cxP2BE3pXvDmOBJpMQgFFNBPpZe1Cs3zdC7R6VoQhr37Or9WAQcTZJM5aIlf?=
 =?us-ascii?Q?R5ZG3hgXrvQb483jmHvRZQWt5IAKRzhm6CVIwRLDzGEFwJrYgbNdtiJQB0G9?=
 =?us-ascii?Q?vFn+eUQA1Kp7p79Fjdcpmj2iRCrUZ8Rpg8O3TYCfE5w2zIzzi+wjiTCLU2uA?=
 =?us-ascii?Q?f7rLtULOfzRpF4CvkUIMbh+XRk9rNqBcoIXw3JYsl6JaDN/lealL0ZZws9Dr?=
 =?us-ascii?Q?m4hbPwic+yhWdI2bdzZcgQaAf6m1+g/jnBGReXDnX+ZIcEHIuIxJBOYK2Ue6?=
 =?us-ascii?Q?qNEE9BRPSdOnZj0Z16LPd6g5gWsw7pIkJqgE0CabSUs/Jov3jSm1HNooG+TJ?=
 =?us-ascii?Q?b2gQxSYeLkL8OHRMeA5+IGPZhXMClvPFdH1aljSCFx6qNI9aU4RsHAW8/mNP?=
 =?us-ascii?Q?7Jo22XhNxzGYBky2hMtVXj0d+YfExG72XvMqNjB11PgybDrQ/my3OIi/nk0g?=
 =?us-ascii?Q?gC2N9e1gqYzvcSiryCvuZlKRS9Cvxho8LA0KVlrIJsBKoMpSuSUgKPQu+Aev?=
 =?us-ascii?Q?tB9dAQMid4An7qglX0YofdTmFtXabVc8jLrbGKO4dtWQN8Rb4zWotJSm3q9V?=
 =?us-ascii?Q?9rREmSraPrgUhi2oYVTgEL0RrOQlbgfsb8hr3g3jIB3pAU2YyGJ8D96EkOC9?=
 =?us-ascii?Q?LBRlQxvfYwapA5m9LeKEsfWREIldX1HU4d1gtK3tSGNDBNGchJhJ0xDL2p9U?=
 =?us-ascii?Q?U0DF4WYJqnNAggt3SKmAcrGfXHgkpuV1frkvuS+Xxw/TcT6Wxgyu0KYdnnxm?=
 =?us-ascii?Q?QZEhzc24aNO8BQZzkRQ65WMHElCK7KdHHmN1jc14OPhEIC+CAiaqF6MGPR/1?=
 =?us-ascii?Q?m56QCOnKXQdjsOLSJ7xJDa2yPMwGCVZIneUXwJVWuhq7CbAe77y/Y8YXzg5y?=
 =?us-ascii?Q?CmFgkyx08BJ/Tq1iSpTD2M+2ymgDLEzAO5yHPemEvL6oWq19ly3xxNk6YHda?=
 =?us-ascii?Q?qiZVmeDfUbDfhVfarnhA+kwtoeLAtD3zrWXTCZmoL7k8NfmSkdRBpJOtrUPe?=
 =?us-ascii?Q?Zhu7/BnugZ6I9pFN3jK8Y12i4PXLU9u1rc4N2wdVq8RdGQ6W0hwfxoxgvHfz?=
 =?us-ascii?Q?wFwALBdMRn1ciGlmReQaNCHHKBzflcrdVG+hWNKZ+oc3Mf0b2upwIgy/efH/?=
 =?us-ascii?Q?Wr3ROh5ySrHCfinNkpi6ZCSVOzLR+TdCr+OTlfnHLdVOy4p0VNrPzr8icpIJ?=
 =?us-ascii?Q?Ld/4QWlor/fPah4+3vOBzKR1vYFr6c0W5Y22TIVr276DIsQ0L3nuPTeo1OJ/?=
 =?us-ascii?Q?5Sb3/yXuE1Swxbo1yhNpZHZ2jjXV8Tn0vFvAfjtt+dsZaKrWKFncAm+ChKOR?=
 =?us-ascii?Q?vAuq9pHdoW6sHO4Uwc3Qb+8LruaETNZv8QRVSE0q+TYVI7Tjj4dAQrzH/Qsk?=
 =?us-ascii?Q?DORRDTFAsSoLLWGcK+OLGxVrAktgAO6rJjdRtav0ewKvt76e/b/OBz7Hac/b?=
 =?us-ascii?Q?Rt+ZBmdXA4/Kta8rpJ1bC7XIPq0QT2LYDz+R5BX0mlG71G7lyniNZQoHl28V?=
 =?us-ascii?Q?aut028ESvL9Q4paIprPcHBxn1RufgLDfouQGGFwWutOINTbLwKEjkBxsWWqT?=
 =?us-ascii?Q?I+uaicTDMz5PlOAjpT1HHbvTbb1OS40aOMvnppCtbFlSM7Wc2kZu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a657b6b0-1dfa-47ab-42d5-08de5d550302
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:34:43.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgLPZNL/H16ZX9BxeDvY3xNSDuuxBKF9pNo+GXOJWa13YygUveELqFbQBHqs7lOSXbt0DUk6qSTgMxtaX+2RPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5626
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8522-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synopsys.com:email]
X-Rspamd-Queue-Id: EB6288FA23
X-Rspamd-Action: no action

Poll completion for channels where local done/abort IRQ handling is
disabled (e.g. remote ACK scenarios).

This is useful when transaction descriptor is prepared and submitted
locally, while irq_mode is configured so that the peer is supposed to
ack the interrupts. Without polling mechanism, locally submitted
transaction would never complete and would stuck.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 104 ++++++++++++++++++++++++-----
 drivers/dma/dw-edma/dw-edma-core.h |   4 ++
 2 files changed, 91 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e006f1fa2ee5..910a4d516c3a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -6,6 +6,7 @@
  * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -312,24 +313,9 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 		chan->request = EDMA_REQ_STOP;
 	}
 
-	return err;
-}
-
-static void dw_edma_device_issue_pending(struct dma_chan *dchan)
-{
-	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
-	unsigned long flags;
-
-	if (!chan->configured)
-		return;
+	cancel_delayed_work_sync(&chan->poll_work);
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE) {
-		chan->status = EDMA_ST_BUSY;
-		dw_edma_start_transfer(chan);
-	}
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	return err;
 }
 
 static enum dma_status
@@ -712,6 +698,70 @@ static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
 	return ret;
 }
 
+static void dw_edma_done_arm(struct dw_edma_chan *chan)
+{
+	if (!dw_edma_core_ch_ignore_irq(chan))
+		/* Local side handles IRQs so polling is not needed */
+		return;
+
+	queue_delayed_work(system_wq, &chan->poll_work, 1);
+}
+
+static void dw_edma_chan_poll_done(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	enum dma_status st;
+
+	if (!dw_edma_core_ch_ignore_irq(chan))
+		/* Local side handles IRQs so polling is not needed */
+		return;
+
+	guard(spinlock_irqsave)(&chan->poll_lock);
+
+	if (chan->status != EDMA_ST_BUSY)
+		return;
+
+	st = dw_edma_core_ch_status(chan);
+
+	switch (st) {
+	case DMA_COMPLETE:
+		dw_edma_done_interrupt(chan);
+		if (chan->status == EDMA_ST_BUSY)
+			dw_edma_done_arm(chan);
+		break;
+	case DMA_IN_PROGRESS:
+		dw_edma_done_arm(chan);
+		break;
+	case DMA_ERROR:
+		dw_edma_abort_interrupt(chan);
+		break;
+	default:
+		break;
+	}
+}
+
+static void dw_edma_device_issue_pending(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
+
+	if (!chan->configured)
+		return;
+
+	dw_edma_chan_poll_done(dchan);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE) {
+		chan->status = EDMA_ST_BUSY;
+		dw_edma_start_transfer(chan);
+	}
+
+	dw_edma_done_arm(chan);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
 static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -739,6 +789,19 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 	}
 }
 
+static void dw_edma_poll_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct dw_edma_chan *chan =
+		container_of(dwork, struct dw_edma_chan, poll_work);
+	struct dma_chan *dchan = &chan->vc.chan;
+
+	if (!chan->configured)
+		return;
+
+	dw_edma_chan_poll_done(dchan);
+}
+
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 {
 	struct dw_edma_chip *chip = dw->chip;
@@ -772,6 +835,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->status = EDMA_ST_IDLE;
 		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
 
+		spin_lock_init(&chan->poll_lock);
+		INIT_DELAYED_WORK(&chan->poll_work, dw_edma_poll_work);
+
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
 		else
@@ -1026,6 +1092,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	if (!dw)
 		return -ENODEV;
 
+	/* Poll work can re-arm itself. Disable and drain. */
+	list_for_each_entry(chan, &dw->dma.channels, vc.chan.device_node)
+		disable_delayed_work_sync(&chan->poll_work);
+
 	/* Disable eDMA */
 	dw_edma_core_off(dw);
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 0608b9044a08..560a2d2fea86 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -11,6 +11,7 @@
 
 #include <linux/msi.h>
 #include <linux/dma/edma.h>
+#include <linux/workqueue.h>
 
 #include "../virt-dma.h"
 
@@ -83,6 +84,9 @@ struct dw_edma_chan {
 
 	enum dw_edma_ch_irq_mode	irq_mode;
 
+	struct delayed_work		poll_work;
+	spinlock_t			poll_lock;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
-- 
2.51.0



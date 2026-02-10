Return-Path: <dmaengine+bounces-8877-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN2sGEs+i2mfRwAAu9opvQ
	(envelope-from <dmaengine+bounces-8877-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 15:18:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E411BCB2
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 15:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 530CC30329BC
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAC2372B57;
	Tue, 10 Feb 2026 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="A8u+EWk5"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021072.outbound.protection.outlook.com [40.107.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06936C0A1;
	Tue, 10 Feb 2026 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733105; cv=fail; b=Rq61W6mOvfmwqds7mvFARsu2lpgAgenJNDl9IX8JytR5kBE0IW/zsB6lM9jr6HQCcHgkGnWh3k7Huhi1qdX9gbPY7kKKMy1QE5FU4pnsIwDAdnaWbEp9ATQteTAuMlYNPwpGFHl3DGfSdJslQcvV7hOXIYTQ0DfxZR9RqDMaLxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733105; c=relaxed/simple;
	bh=wwycRBW2dp2fZcc7PudeyH46CNDVNi1WRQTdhdrKa9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DV0P9UFjxIEQx/FPioETizdTWLKLBdXnffZljJA6fDZWHEcUISvVnwwcNmhosBgmF7jNvajGY4TRJszArenoXwMsLfmnTSl8uHO4OutBJlj/6HrfMUWsHflAWiKnPcs0KN8qYUUlh6Fijt2545VGLSKRBMHzZ4Ge6Yso330Lw2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=A8u+EWk5; arc=fail smtp.client-ip=40.107.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCYOjrq7WQcv44H2txVrsFY22dj0+ADT1J8nm9cO39CsT/7RKvoyXs1mbk9/mHHek4Ivp+Q4BHUO3+0TRlY54M/1arUcb3BBH/9IpWjMi9lLsixonYkigjSYx/9FCKcyrOF34d2CBih2Tp6nLCZhWNU7AG4ec+twORnBkhAWhKgOeFu0H5ZQthk927IvLH68qU686swsdM2YwKRLtP+4gQ/J32UgRAtPVu178Kg+daPxQpkW0chmONvAjYpnPo5n5p8+py3P/IacRTJeS0frG827nlra6+FEbZZq1m2codcyLm64TSQRDuv3JWThCRd7dxSaAifirp1loYrLVtQwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s65eboapt+yPHe0e23CKI2GCt5Hp7Qu64PyYxRBe5cI=;
 b=I06YbPok4GvPRNaP3vPCMuqTXy5avoGArDZTACLfQ4xfawO1+pRP/VVHuxnkdd03Hjif40MER9QYCdGvT1w2I0DAq/vZTkknnnu/ah1izXJtcF3JWOZbDvWx5L8kq8uSNeQAQ4AH1vDH1znFftN7nETRibjtjO3BovtuKe/MgtVM7WhlmiibYZZkCYIcVaFfImdg2ilvYBVkRSS0QVwoxwc6kulJZgFXRr7tNA3pzMY/j3vBFB7pRcky/dUTZ2J/RxWY/fqU1VHGe3pAaFEDj50nJJR8pVZzOQYbIlz2Xfkjah+FzsgXLNHjLnPpYIcwCjgwyxoXrGlWEhz4FlWVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s65eboapt+yPHe0e23CKI2GCt5Hp7Qu64PyYxRBe5cI=;
 b=A8u+EWk5XMTG03+fnoh86yENnagkoVRBMfheQQkO/G/YITYPoe21ld2uZ+3QJWEAZUvA7tun67iyWS3aqkAPmgyQn0FJ3Kf48qYZT4LSK+7bK66AJwogjmUqj4mZ6s6Yu83yWLlGpPWIa5bOtVZs+WRAxX1k6Q3WZBP89P8Hhy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB3866.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:18:17 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 14:18:17 +0000
Date: Tue, 10 Feb 2026 23:18:15 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, vkoul@kernel.org, mani@kernel.org, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] PCI: endpoint: Add remote resource query API
Message-ID: <3t3or7gm6a3v5jhujzy4g4zkcoaqqexuh3alqfibqqt25yrptu@n4qdb5yutjmj>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-5-den@valinux.co.jp>
 <aYYsfSTrrLbR_txR@lizhi-Precision-Tower-5810>
 <ihe4sguchgrbiskeq5ht3tcti7yjzhsdhu7nobvbejbqtlr7dd@3n6p2poipy6d>
 <aYsieMlRDH1lRPwZ@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYsieMlRDH1lRPwZ@ryzen>
X-ClientProxiedBy: TYCP286CA0188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB3866:EE_
X-MS-Office365-Filtering-Correlation-Id: 535594a2-7d02-47a9-782b-08de68af3c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RpoVuKPEQPQSPToY763rvfXJkNDAmNsLnnlCQsuttz4HnWVvpVoRxQhA87WC?=
 =?us-ascii?Q?xcRPSynhM605QmJAoR88Bqkwl7V2amOAao2Wm0taMDGLZvnqDvMujA4PQYgR?=
 =?us-ascii?Q?oRSgt75uVgpULWv51tkyK+NIrkAbrqbRKvHrrCDYQB44V1xFNqYFDfkrMkJs?=
 =?us-ascii?Q?6wpu5pg3YCUQULHhpW3o7Ysh6XPMe6YroLz0wD6B/MyOSq3zIK62ylwAnsq6?=
 =?us-ascii?Q?RfxY17x57AaBMdiq/eQCr7koXqGzW8pomfRUBMUKFdMlxtzgEYXFRZiQ8K3J?=
 =?us-ascii?Q?5ktdqidWhMVfqNmEykO2kok0p3I6WUey7YFcX/mQAMT4Mcol2oLV9R5Fy+90?=
 =?us-ascii?Q?LYTbujoGofaJR/bL9YyBrKnk4CGdtcNZDX5l5ZaMWuEWrKG45Q+E4BDthrjz?=
 =?us-ascii?Q?ZwDQJbZqu2PkrSqBaxDUJm0bJIBc/Ud5tupry49Ws5L4o660OUMl2jN5u6Gv?=
 =?us-ascii?Q?dj2WqBR4wMyjopE7EAuSTwIiU1N5jYaCSjkrlmtw8OKUXCFyK/+fBwpDswk+?=
 =?us-ascii?Q?raa+SaYra22Htx2rEOJeXPRMJjI15WB/KQMZQJ3yZypmAhaQbkCbUyfAX3aj?=
 =?us-ascii?Q?zwoXDh/XbRlyPsnqO7+0IbzSYL0rfcF2iMGgFplksDT2doshg3DBZS4KlARt?=
 =?us-ascii?Q?s/qjYDLcdDiC00W2tFWfTSLzjjqxIuBXoAr+jNVWckEdmNOyI3gaRiyfdR+3?=
 =?us-ascii?Q?mQ/4Ohbjdg5dzytaUYeS6OwJLwj9ul/1+SxxnoW/PoW9vrTjzP1NC+ab+WnP?=
 =?us-ascii?Q?uIZbZxyXiIXKvv7EAJAvKesrBN4D7e8UIu6zgJJ7GhS3NzEtFcjhTOJsQ6TV?=
 =?us-ascii?Q?H7CGGmedTH4Jhe/kcsjqh3GI7GosLNj9ZkzKEm7waC7xdd7+ulp0Y2Rzfh76?=
 =?us-ascii?Q?GIcs3wRMKXJa9x7yhuDeWREp3Pwn1BJibvJJyunGdgJF2GeuilJL4b15pIZa?=
 =?us-ascii?Q?TCP2/FGW2OF9HS6+Rb5HtL+17PP3n0ktvEqbBcNusLBxUHvmTR68n88YvDHf?=
 =?us-ascii?Q?8NyUA+M04qUEIlPphnnYqrswVodF7Xc0gL7ytqserV5PklWmwpUKbq6rqsKf?=
 =?us-ascii?Q?1fNaQrWDydoG1GWIcfVQRRPRLe0zJ2JD0ew3t0ADhkepw7CBud/mSALKpDhe?=
 =?us-ascii?Q?9rc0QXeg3hl5uLcvSzxH9rqv1BaC8rycB8eY+UdmG63du7tCsK/1UZFMS+QX?=
 =?us-ascii?Q?zwi/H7xjcc03us72Xh8WSaF5hn8rpvuoKu8Js52e5bIxKBSQ66Ui8OAtI+Za?=
 =?us-ascii?Q?GJ7fEepSe8sLD1cpbkhukGe2EkaXbQMcTy4ACbkzQshZS8yhCu/kNh+CmRzl?=
 =?us-ascii?Q?Jo1EpuVbekB0/uvem646ggGWYIHk2iA2JYRR7lqDK2oQGyjYDagts/HfQvoc?=
 =?us-ascii?Q?ro1zL7K+JCYbnNpbH/m9tWDUyDcc5hVEa3hef/XT3nJB+vhI7ZiESXItDuIN?=
 =?us-ascii?Q?HnEcllp6vgnhA632nAsqk4lqRAsDo17AFDszEkEQUwyswYEp4cFGeLFz9QPA?=
 =?us-ascii?Q?RwgLjBDOLDqUYm6fWkE4ef4SkB5blJgsUrxkVLf86z7EYVZqiep5e6WoKRc1?=
 =?us-ascii?Q?icZQqQj5Yhog3u/7oSY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dQdx9HVuJepVa2Jbd9btIe5xkEvdLerY8f5r9SQhGS4+dXQ4P2N6F1+y9uHV?=
 =?us-ascii?Q?2zf+t+7XE4u4IB5aQs4LLM0yS38LOJ92OWRJSCgq7MSGTgwCgjtL9d+uKs6C?=
 =?us-ascii?Q?hOQyXq/Yzo/H/XuLG5RgwoKHHILN9Iq5EwRYf9Lz2TqYLR/ck0D1a5Vz/CjW?=
 =?us-ascii?Q?HuW42oH7wVluHw8DlBBLTwpao1j0lJBPbKknYsGAz+8nhAMe7PxgJ7PSZkna?=
 =?us-ascii?Q?FKO5tBpyYGX7LC9k20qnpV5q28SgvvbUfmN6eNehKD/SywM70akO3YSCTiX0?=
 =?us-ascii?Q?OeSit6F4svUHV8+tgfhVIrLQuSD5ymAkkoenqnbL7wFciHojH8HJiWpBoyxg?=
 =?us-ascii?Q?HN9OD/D0eYJi6OzYdz5Mq8Ibh3wxDXL8vWH5rn+lRH/mkOVWEEGL+rpOXqBM?=
 =?us-ascii?Q?t+9zH+J4EI40BPni+zPhhXP6AdDtQmt7GCjDG4R0ZL7sWDc5tl5J/DD239EP?=
 =?us-ascii?Q?Av4A1f0NvM6DKAs//3upF36qcHoFABwPHlPtXGxYT/S5wS9l5zPsn1DlnSK4?=
 =?us-ascii?Q?/Nn6faa1vobYLf593w/I0sYAY9rO9kL8YaxRYOJ6pqLTfBQncl0my7Gd3qGS?=
 =?us-ascii?Q?S3k6MiFRIWYNWw50ACjhy1uLwkAOahJwwDXTajg+bq+vy36XtZmBCgLbJtPB?=
 =?us-ascii?Q?gkmENTPZ5hyckpnaCfEBbr6mlH9uP7CloNDBMimdIcyJmhU33/PhsIPcsPB4?=
 =?us-ascii?Q?JBizoMTLXFx35SXhFXEk8JXrTmDJ/CTMDcCnAFh2AnT1QFOrnWtBJxKUeR+7?=
 =?us-ascii?Q?rTZ7SFbiFj4wCYexGMBmkxZ/5APRF9fFO+fN/9z1oFgJ8yI7SLAu7NNy3nHL?=
 =?us-ascii?Q?VzmnqhH+0PpkXKzzJObmfGZBJiMVm117y+H4ihspklvjPNiyxvPXOh0sbxRG?=
 =?us-ascii?Q?6XFfVs46voHOI4hoXMNiepoDgCGGtTt2WMulovv9LpEWktt81uLrwPc8Dmy0?=
 =?us-ascii?Q?kzwxXtCnN7FCYXITz/ssftmRpu7OTzLV6nblhf3y40kr0m44i0mEVhDB7Tt1?=
 =?us-ascii?Q?EQtrv5IA95QhbOhj7bqgGa1Zk1Y/bpnbWi0F9VXZkZiQ5cWAIzY8qTbXbK+1?=
 =?us-ascii?Q?Fy6vskXcDvmy4utrrSEAwl6QJpoVfssBFAba8kgWOdbbOGQ/CsQCUOkczXLK?=
 =?us-ascii?Q?GWZ8DaDcnjuPbu2pgtdvRWG1WygrqI+3OPJXBZP6QwFHdJLeuCoeX5IqffKx?=
 =?us-ascii?Q?jcl4uxLBscJO8ESoQnA1DcyDnc7ChuZlcyoibqUJa2K8jxUhO1IU9R5jNXqR?=
 =?us-ascii?Q?Gfdvg8gnMILFVf+9YyOdy//SwPvLCBHlLk/CNJq4ChYshVFZ/u5pKIRBylJH?=
 =?us-ascii?Q?iGBtksezU1b5xswAdN9mcDq7LeQLYm4G7jgyLsjIaZ08e7nTXtsIrb6WJQh7?=
 =?us-ascii?Q?KUCGLrifx58dPv7FurjlCKGvXezS7K7/TJITySyTOIdlwB3d/rveAfLcqPXR?=
 =?us-ascii?Q?vUYEu6DdbN1RE4ucIUb8gwGZd2NYTsTwOlH/mQZOdQnG9mDzbd9x8K5Dv9om?=
 =?us-ascii?Q?knOc6HjpgKUBYPW30rzjybruy4sscIIWjmUpe/R4MM6XDXrkHcXqTwpocnT+?=
 =?us-ascii?Q?1vrOlqhgu+GoghBox8aAhz2ZlPKeWRPGVdaawADWqRhtHm86C2wVTS4vj7SF?=
 =?us-ascii?Q?KE9K1CHGe6PPfB8oUGvp65qjG9QhlTbtqoY35C/zxW1PXd2cpZ3aXAL5W2Zi?=
 =?us-ascii?Q?ox4dLt5NewqkgtXHY+wnieK+hx05xhHcWJ54nb2HZTSTY4p8nniPsiddixZP?=
 =?us-ascii?Q?RCg5Bvl7791u3rSUV2agj/+1uN0/VA7NRj125SQDwu6vHY2Hmezu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 535594a2-7d02-47a9-782b-08de68af3c5c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:18:17.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnqdXqKRExprrvD3ZUeINTPAWoaApapWUdAl8nrwSOMU2/+EhgOrh6woFUsVbfuu8SIEGLZoDavdFL6nrPETMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3866
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8877-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,gmail.com,google.com,vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,get_maintainers.pl:url]
X-Rspamd-Queue-Id: BC7E411BCB2
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 01:20:08PM +0100, Niklas Cassel wrote:
> On Sun, Feb 08, 2026 at 01:39:40AM +0900, Koichiro Den wrote:
> > On Fri, Feb 06, 2026 at 01:01:33PM -0500, Frank Li wrote:
> > > On Sat, Feb 07, 2026 at 02:26:41AM +0900, Koichiro Den wrote:
> > > > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > > > engines) whose register windows and descriptor memories metadata need to
> > > > be exposed to a remote peer. Endpoint function drivers need a generic
> > > > way to discover such resources without hard-coding controller-specific
> > > > helpers.
> > > >
> > > > Add pci_epc_get_remote_resources() and the corresponding pci_epc_ops
> > > > get_remote_resources() callback. The API returns a list of resources
> > > > described by type, physical address and size, plus type-specific
> > > > metadata.
> > > >
> > > > Passing resources == NULL (or num_resources == 0) returns the required
> > > > number of entries.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
> > > >  include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
> > > >  2 files changed, 87 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > > index 068155819c57..fa161113e24c 100644
> > > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > > @@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> > > >
> > > > +/**
> > > > + * pci_epc_get_remote_resources() - query EPC-provided remote resources
> > > 
> > > I am not sure if it good naming, pci_epc_get_additional_resources().
> > > Niklas Cassel may have good suggest, I just find you forget cc him.
> > 
> > That's true, I just naively followed the get_maintainers.pl output.
> > 
> > Niklas, I'd be happy to hear your thoughts on the naming here.
> > One other option I had in mind after Frank's feedback is
> > pci_epc_get_aux_resources().
> 
> Name looks good to me, but I think the cover-letter can be improved a lot.
> (Even when looking at the cover-letter in V6.)
> 
> It seems like in v6, the main motivation is basically what is described in
> PATCH v6 8/8.
> 
> On platforms where such an MSI irq domain is
> not available, EPF drivers cannot provide doorbells to the RC. Even if
> it's available and MSI device domain successfully created, the write
> into the message address via BAR inbound mapping might not work for
> platform-specific reasons (e.g. write into GITS_TRANSLATOR via iATU IB
> mapping does not reach ITS at least on R-Car Gen4 Spider).
> 
> I think the first sentence in the cover-letter should be that this series,
> for SoCs that cannot use GIC ITS, provides an alternate doorbell using DWC
> eDMA.
> 
> So first describe the problem, then describe how you solve it.

Thanks for pointing that out. Makes sense. Let me polish up the cover
letter accordingly.

> 
> Perhaps also show some performance numbers. E.g. vntb, you can show the
> latency of ping against the ntb netdev, see e.g. the commit message for:
> dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
> 
> (I.e. compare R-Car Spider with no doorbell vs eDMA doorbell when doing
> ping against the ntb netdev.)

That makes sense as well, I'll do some performance measurements and include
them in the cover letter.

I'll send v7 once the remaining discussions in v6
(https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/)
have converged.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas


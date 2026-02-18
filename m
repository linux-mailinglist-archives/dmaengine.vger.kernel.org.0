Return-Path: <dmaengine+bounces-8963-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJEpE3/mlWm3WAIAu9opvQ
	(envelope-from <dmaengine+bounces-8963-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 17:19:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CA1157ACC
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 17:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2F1300CC32
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCD2F0C7E;
	Wed, 18 Feb 2026 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oCf/gIz4"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020115.outbound.protection.outlook.com [52.101.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01F288C0E;
	Wed, 18 Feb 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431547; cv=fail; b=PqMOFY3xvwOaQnXnwHTvCHvgE8+P0yLfSAcn0gj2G3797kLclvQ6mS+o+ryGE9cq+MycusWwaCToQEK8Bfbxpbz0L8Eda8toETtnYFb7eTlhOKp+MdlmFgcMEg8KFnOag612YymsvGZCUNsA+Fg43h9fUqrSxLcvHlydFPHxlvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431547; c=relaxed/simple;
	bh=ESag3et6gLZUzWhyuvRBurdUiCXpO7b4oSyF8fGVNew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0mpFKZ39QGXv4LAafRpYbWdvClu6eH6Hkhn+UGvWFkyQWtPW85MLDrGdWVdgj0frcPb9eNyx2g91+NVe7XIJdmprWrsPWKM1oaAERbdEDOjeYr1dTtf6vz922VfmU0PIZTKYEGa+78ULTu1Qh7ay52jkdhXLVkZW50bgWetuSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oCf/gIz4; arc=fail smtp.client-ip=52.101.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gtrvr1fnfL3XA63zDyfulWNjadkTf5NlkVVsmBV1Ndqq8Jp9uAceQ+ToEWwBC/KOQpGmsjW4JknBsbhOJGblCLYjDvsEV004ntuQyJnvb792EDsedKA7exu4T+C1i5SutZUHdq2hBDdFe+PFRVHHMcxqj6Halp9yHNHB+JeTii9LEQNi4iBMsbj6PwqDdB0Mo11+rEl0yU9UKsafTJA+69CBHidLK44A2z0yCDo7JRDVdr9vgR9leqL+YwdPU7/mQ0murWUrfhAQi41YphUf9Yy9tM4D2uSZUK6fuzHjqYRLhc+CaOe6/Zf6yTzO09Jj8sG9p8doAZxi3ufO6mO/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQmCsr6PYUtqWR0md5TdC8aeFqvYmqSUDPipNmIuws8=;
 b=uUKAJ9hYK0YvFwjWwsQWEgymiPWfAbaC8ZsGIvVm0u7GJJ99YyONL3kvlbFfZ9sFooGKJJotsrZy68soG/TsZ/aEUY0ljyCtWPm48v996R5+Bdcj9jdgMnaPzRkIzuC4ddTsWaNWveUAeMsrfRAToX96RMroYExjAnEDOV5u7Id3PP3J2dWNhbUmVYed+uUeZsQogVumtdILRdyKm4LWoiLA8X8PZkKQhSko690SLI/cGe2cdgTVwVe58Ff1Fzt5ulNcRbpqDDm0s51EKrTYYYT8jzz3Pf96Gkm1zaYIivYyp1AW5RV1SVNmQGGx/DQmW9bIOev8Gtv1vqPcD4UWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQmCsr6PYUtqWR0md5TdC8aeFqvYmqSUDPipNmIuws8=;
 b=oCf/gIz4FpufyVk7xfDYD12J3VlECcpwKNfLrzY8UAHx1bvwT6nyjseArM4MKFdQXuh+jB4AyCSB/4L0ZbyZo44ore/12q6Z/Wi4QLOCXG4YGPNq/WdfGlmMetIv/jiYXEBJ7BOB2ESMqymuPlo00p2Bw9UNNaLtdMRTGsiNefs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6429.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:41d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:19:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:19:03 +0000
Date: Thu, 19 Feb 2026 01:19:02 +0900
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
Cc: cassel@kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell
 support
Message-ID: <2p7rmtp7aak6czf2yinbdqa6w3c2j55pw7dxahsmzeiuceg2pk@4rzpd772kcbq>
References: <20260215152216.3393561-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215152216.3393561-1-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c4b4f1-9706-4282-60bf-08de6f096ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yGDJlRVereKwf5btwyhW+WzfztWFpZ+8uh4CsVcj6A4DxJJnU45rq0Y254T?=
 =?us-ascii?Q?qu5Nym1GpMR8q8zUtxTQhOec2L2b0bLTtEIxKE+ILArvsqFfDQTCTifNI4+R?=
 =?us-ascii?Q?miEqBQCREurzJu3+X/RRvg578ZzmjdR5+zk8QHlF7vM1W5rtuEks44Y1ts2P?=
 =?us-ascii?Q?FtOYiJTrhxCr2p7xXxrKD0tVp5rglLn75T61Q1JLy+ACmw81/I0q9jpiQMeL?=
 =?us-ascii?Q?WWiMu+zHS7zyr8rMpYc5jQCOz44EvFm8UDSMLVWqV8EaDL9IAXlIwgJsmusA?=
 =?us-ascii?Q?laLsDnUkU3ds6SHHLN5x3uw8jvc+n79d2nnjGJr73srDyFa/FjHdPfr4apac?=
 =?us-ascii?Q?f7Lm3v/RFcZoi514HqvAZIrbS5hYvZ5hv6S9qxV1xJBB32z6p1Q1NDqHSslv?=
 =?us-ascii?Q?f3qjCwBkhhP+GgwA/hFfMvLK/Ktu4CqwHuMUWQw5b3iHpFVEwHuw27HkoqtC?=
 =?us-ascii?Q?a2U/ogehGE/Wcmn41WupfUWct5pIrANdj+9s5Wjj6/pGsqW2vl8Ru/5spXaE?=
 =?us-ascii?Q?KZ2eoty8Mn6+GS2vbWtKC6sm7BOzco5r/YIUaWChXPK70CZrjIhknkNafEaT?=
 =?us-ascii?Q?pfNQajBMEajUeRC+y8wI9K+maSiX/KObMPnN39+X2nrqe+cV1AQAQmK0RkMH?=
 =?us-ascii?Q?7zqnVGPE6PqGnh6BnNGCpjBJg2TLZvAFepYIgkr3TiNdVt2lLfguf31Gna9D?=
 =?us-ascii?Q?79kbmiD+jXxVcp2qeDoErKWJlJYykx2VTuyTgt6bRgKZfac2mfToi18fYga/?=
 =?us-ascii?Q?I1CbCMg1wmKu+tUAjZaEjnjsU3h3JWvMh+woB8oU2OzOEZS9gOFeHbtkBJFp?=
 =?us-ascii?Q?fAdpZ2tpM/k0A3eAQJHHMzrwHuLWj6ciqyUjw9hFWHVQguyZqBMLh3ZBkAYV?=
 =?us-ascii?Q?kkEDsGNdbBaS09HLqmgy+foolrC6BNwcPXZLt9mpjLtHnixsFJgqeGxXClR8?=
 =?us-ascii?Q?z/cCTRzehNkCtqdKwzuf95LtrzqvztSiVN4HC1jkXUtlsRompD1WdJU8ukiC?=
 =?us-ascii?Q?zWhD1kZV383RVjYRu0eT5EVGPpwxjVmwZDGb7ks/2ZwWf5H4RXRPX1YicqHN?=
 =?us-ascii?Q?x7wuYI8boozX/hilZhQ9x8wYOhXH5ef3aYGxBgjsrV1/QUWengn3Qmt0tWKD?=
 =?us-ascii?Q?IJ1IK+Lnd8/nfAs6I2VUj4GxVDQ8zC9vTu0+2ccMFhWJdY/36BbSKnkYnwFR?=
 =?us-ascii?Q?sGPI65Fe2MF7umIKDy0r/kuoiQZ5Lmyfy1wBjKmjk9/li1nkqTm2dDon8T65?=
 =?us-ascii?Q?8Ip5+JFUY4hOhrNjQAvKW7nORuMwydbX8tfDZi80Kha7r1MjA3YNlI9ZNeIi?=
 =?us-ascii?Q?xCpzxYADQssgxvIGtvFZfot1xbTpD+HIUW2WPu4Ea2SAsNJQva8jbM3d1Ey6?=
 =?us-ascii?Q?dT9oowTut0fmMU3YEfWgBBVpE30WKXgG1BX/0IcNj3VxhWQTCq1qzWsmR0aa?=
 =?us-ascii?Q?QJ1lMp107ow1VKuXkDy8TwMa8CwFrmER+UgHy7UJ8WBUNLi8M7BcEQAHq5tq?=
 =?us-ascii?Q?/Q7x8OLiToyIFYJR3H1+mJTklC9RI7BTBd96bi2P6E7GPc0D6X8cawoUlJM8?=
 =?us-ascii?Q?6T8obQrh2z1Bj9yCWUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0M95lpHC6FZjSqpfMQSYe+QuFweL4TacqDyF2PBolVKTgXC9CPPUVqa1M0Y?=
 =?us-ascii?Q?jy3Z372H2EtiJ/NcH5RWYOkH1zEUIL7YQ7OGcMPvx8LZj3sKe6xMCq84EhqZ?=
 =?us-ascii?Q?O1LBmGQPrFs8uB01ry6mIcAqqHGeSy1mTBbjY8EfkSjhXBR4JuNZE6OkjzPm?=
 =?us-ascii?Q?18gPzM0rRsAf8vWqHFbWZW0tQncq2P1ctqiHNAkbDvzEeR21TI6wXbbZPV79?=
 =?us-ascii?Q?hu7bMnUbKbsM5nxXIKZlPXcC5O9aKsrBVX0Hk/KmN47QlbBATs2mJo3dsM8T?=
 =?us-ascii?Q?0pgLnx43RA9rjstwLGKaDKe0HeedRQGNeWh/U/fOJp8z/3F630PFR5jsdSCp?=
 =?us-ascii?Q?QhqK2Eiabt0HVx5cW5TIkj17kd/XSYcJLJb2Au1mR0D8MHcuGZZhPQ87YxeL?=
 =?us-ascii?Q?+cwtKGEx2JXxxs8TLlqScVgm5ITT/RYmCOXCDxtkxcjdB830x1Piw+zNqMzj?=
 =?us-ascii?Q?nBVurxb/0L5D8F71oY8dJ+Y9ykR/v+9JEFHn2MHpo7VRrVmR02KIPEh6AhVe?=
 =?us-ascii?Q?B/dJFxvpXiu0jIVaJ8iVpdHD8Qst8OocuMLU475gsgfJ0qBzKGIrLCVnRv5l?=
 =?us-ascii?Q?Gcj17cBbpbVnRLjUppP4b0FOo9wM4Zgk0ZP0t6rudDLX2nnRPSEXtOUbLDxf?=
 =?us-ascii?Q?rnMXb/3GBIePaqdVcA0hEnDUrQpJ2h1uVTnHgoPGKp69Uq0uWnpJkNi9FyxO?=
 =?us-ascii?Q?2ZEnXXvULmD27wIt4B42WKSOG7g1KAoYpSymb0vaH4eyVmBN1pqRYiJa4nw2?=
 =?us-ascii?Q?gf6dEng5sWGpOY/rK7+bfoOBACuD6in872J/dDboTYNf3OdmIq+zD77Own2x?=
 =?us-ascii?Q?T59hoUu43klDvgAsehzW4Tq9iUXFfNJ8dEff6tnAnG6POqHdoGm0t8tZvV9C?=
 =?us-ascii?Q?YYIx0QKwyM1cimAa176kasYQRhRx0OZ+Ikw4jFoOH/Nq/v+9kAFZEjAij/XR?=
 =?us-ascii?Q?Tn9FHwx7sjWWsNgXKq8LetMO/+0NlIKV/I91NPMGQqbEgfJe0IL0XOtk7iqe?=
 =?us-ascii?Q?96mLOM8MPAm1tKuzEOCspPpPFCSkmV7ZvtehsADNbKJnTJp2qyyu8lA+EEL2?=
 =?us-ascii?Q?rZlAUA5mcxjVeHIntIib97Hk8AphTu3qGrJjmIWYBifyupJhrUSyDmRyUF2W?=
 =?us-ascii?Q?2pg5H72+ObkFTSnXfGQMvaotA6Sey/D0/uYogIx9PgAi0BxYqexG5i5wHAy9?=
 =?us-ascii?Q?JadoIdnhRH9cLSxAr0KhSgYOCs+qKvN7GLWjun0SdiwGjddzDXxpIdBpvtlc?=
 =?us-ascii?Q?jJiCn4H1tTnV2nmichGy5/qsiV0Nvimxeoai1u5rUIwyWkIU81q32KOfOQP3?=
 =?us-ascii?Q?cr1/ov+nxrfhy8TzrlEcY5vyGVf9zd4k15TjO11uMCQh2sJpqHByzERfy5OS?=
 =?us-ascii?Q?zLwczjNcYkMpO6kxu9hm/iQk/ZsPcehwr7I10CjsvbtNiMwrROxZZuY7HLNW?=
 =?us-ascii?Q?Xp30SVmut3E8Wi1QAl8fcZdHDQuVqmt1+cRpeiYFSsQfrYfstgs8PIYSygu0?=
 =?us-ascii?Q?nJnpYJtQuqq1APuOVrarq6uY69ITQ5fdg9KsdxoLxSkYIqeXzWc8/+DKMBQv?=
 =?us-ascii?Q?RvLLEZZxmzwZUWV5eR0tEP5suXUKQYJH9R1XXYjUsid0bvx0U1HNSeJTI8Qs?=
 =?us-ascii?Q?Rqu8g1PapYJ/sx3FAG+AhsxUUR9OaEG41cOXNycnWPisbVNdqOYs2wp507eG?=
 =?us-ascii?Q?WGXs9S2X79G8GLlbYYDMYtURTxWWlvK/DZxddDboXPNOFr95GYt1xA0XIiv0?=
 =?us-ascii?Q?2P2zt4JyK0GkMahvZg339bGS85r19XU7EQbzL7eOLb70a/KYDP9L?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c4b4f1-9706-4282-60bf-08de6f096ed2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:19:03.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwdp8B+BiXkIuKMtUl7MzI0mj4YBE5ygl/Y2H00D+9xYv9DiGWxsFWuHuowmerny7YsQYgIOfDQ9Y8f9r+8SOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6429
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8963-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainers.pl:url,valinux.co.jp:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38CA1157ACC
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:22:14AM +0900, Koichiro Den wrote:
> Hi,
> 
> Some DesignWare eDMA instances support "interrupt emulation", where a
> software write can assert the IRQ line without setting the normal
> DONE/ABORT status bits.
> 
> In the current mainline, on implementations that support interrupt
> emulation, writing once to DMA_{WRITE,READ}_INT_STATUS_OFF is sufficient
> to leave the level-triggered IRQ line asserted. Since the shared dw-edma
> IRQ handlers only look at DONE/ABORT bits and do not perform any
> deassertion sequence for interrupt emulation, the IRQ remains asserted
> and is eventually disabled by the generic IRQ layer:
> 
>   $ sudo devmem2 0xe65d50a0 w 0
> 
>   [   47.189557] irq 48: nobody cared (try booting with the "irqpoll" option)
>   ...
>   [   47.190383] handlers:
>   [   47.199837] [<00000000a5ecb36e>] dw_edma_interrupt_common
>   [   47.200214] Disabling IRQ #48
> 
> In other words, a single interrupt-emulation write can leave the IRQ
> line stuck asserted and render the DMA engine unusable until reboot.
> 
> This series fixes the problem by:
> 
>   - adding a core hook to deassert an emulated interrupt
>   - wiring a requestable Linux virtual IRQ whose .irq_ack performs the
>     deassert sequence
>   - raising that virtual IRQ from the dw-edma IRQ path to ensure the
>     deassert sequence is always executed
> 
> This makes interrupt emulation safe and also enables platform users to
> expose it as a doorbell via the exported db_irq and db_offset.
> 
> This is a spin-off from:
> https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/
> 
> Based on dmaengine.git next branch latest:
> Commit ab736ed52e34 ("dmaengine: add Frank Li as reviewer")
> 
> Thanks for reviewing,
> 
> 
> Koichiro Den (2):
>   dmaengine: dw-edma: Add interrupt-emulation hooks
>   dmaengine: dw-edma: Add virtual IRQ for interrupt-emulation doorbells
> 
>  drivers/dma/dw-edma/dw-edma-core.c    | 127 +++++++++++++++++++++++++-
>  drivers/dma/dw-edma/dw-edma-core.h    |  17 ++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c |  21 +++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c |   7 ++
>  include/linux/dma/edma.h              |   6 ++
>  5 files changed, 173 insertions(+), 5 deletions(-)

+CC: Niklas

Niklas provided valuable feedback in the previous iterations and also helped
test the earlier (non-split) series mentioned above. During testing, he
identified that on platforms where chip->nr_irqs > 1, the interrupt emulation
IRQ could be randomly delivered to one of the shared channel IRQs [1]. That
observation was the main motivation for the rework.

I missed Niklas in CC earlier, sorry about that. I had naively relied on
get_maintainers.pl. I'll be more careful.

In this series, the implementation has been reworked around a dedicated
dw_edma_emul_irqchip combined with handle_level_irq(), and generic_handle_irq()
is now invoked unconditionally from the channel IRQ handlers to ensure the
deassert sequence is always executed.

[1] the discussion started at https://lore.kernel.org/linux-pci/aYsjfTtA0EsXwh69@ryzen/

Best regards,
Koichiro

> 
> -- 
> 2.51.0
> 


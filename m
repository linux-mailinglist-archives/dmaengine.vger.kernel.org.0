Return-Path: <dmaengine+bounces-10893-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCTvDIo8FWqpTwcAu9opvQ
	(envelope-from <dmaengine+bounces-10893-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:24:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B45D124F
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAF923014962
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 06:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CD033FE33;
	Tue, 26 May 2026 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="eQajecFH"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018515A864;
	Tue, 26 May 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779776645; cv=fail; b=EjJeJ2cJv9hPZMeSvGimK5E1KwjMUYDiFBZLBmJFWXZfOTpFqvpAEHu0nhhkdGTlWNOak1muaxdu1eme4QznEhJ9WXBD1nnVZKbmz0fgKCvtxH/78a3yGQD1f11o2xPV5kwo5QiUevfG+ezx1S+6YL3iRrat7+hDzrxXnj5furw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779776645; c=relaxed/simple;
	bh=DOAVpM+kx/r2rgTyxHfO90fPT2EoS00FAAywUi3NmAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f0PxGQijYJZLhYfIL+Pog7i/dgoE472q2xCAxme16v0WUn34OY7v9QWg6Q9mrK+1wk/tLCVN2REAapYJ5e5Zf7fwNoEYDCS6/IyH4wdjftft02pWLL4NaZ3t4Yb3UCiMqJQUHpjsxnO+Xtc5JBQJQUjKEF0RHirejHuFySw8yPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eQajecFH; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmkYXqAlTc9d+fiNf2nQfMd45yF0G+zNn9UxajvElqq8+Ba2kote3You2jZczLl/PmUCypIX8s95+VhYY9e6xSvblXkoptEsYO8ZtOc+FwvaeVBDv+CmGSyXkVg0leQkJfg/M4gtHGgxg2/wRGmH/tQmrm80A1dksrKiJI1ssafbMWceq6Vp3Yla5AvLS/NEzlPg6vjk5ER2JqxrxGQEA2TIo0ChdHd2BJtOw7yUaArIbxghjZ68fS1NenlRatmEHwhjpEMwiqO1vjdsKNxT6D1slG95TJMTZRfMdsGaCAQRaJgpI3+FGgCEoC9cwdp5murawdmTzFp5booAtpcWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=matCIdXAygQBvwCToZcgmY9YQuRh1fRBEJar7Dx1xjM=;
 b=gUOgRkUxiqaQ0uTu27nKRJVpoNIHuIG1au/N58tswxPFkSpTjDeLMURBW3E9a9f38ABVMPgjfU20i468x5P8TsVyYnqgDyzq3BRtFAtcy6VtLmYuZXn1TVabxeldTz5ZeGQgTY/8KZ+4fnMGfOYq7DyytV1j6wtykA3fU5tS+l2dRGEMNn6xasaux056CPNj/tPBKjmX50ScboykOQVQOMNxevGqHQMK2mMbv6aa24g5gTUp2IzQW16m2VcwZuDhJRmSSSY4rYdupHJ3s6TZPYo91GNDH7OGquW5baXaH5wR0/0GXTfDDfIvXCqotG8HA/0h4V1JjfmztR8maGshzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=matCIdXAygQBvwCToZcgmY9YQuRh1fRBEJar7Dx1xjM=;
 b=eQajecFHqO2wBshOdb1HnwTCFmdSwgNcy7H4MVPzMBWFCFFkqDD0wkMlnT1Yfc5CG2WHOTWIyo39fk8aG3vG4/fum6i13hbV+BsIbg9fO8BtsxIyISPg6jrPpf1EEmsCzSo8MdCuk87V71dlgywA43AnyiTZ/hc6TjFHQ3JV1uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7008.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:23:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 06:23:59 +0000
Date: Tue, 26 May 2026 15:23:57 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Add PCI DMA endpoint function
 (part 3/3)
Message-ID: <b5qre4rphbq4datwi3apyh5jy5b7obz4aj3pfn2gzmke6znmib@gpdbheezoi2z>
References: <20260525063456.3317509-1-den@valinux.co.jp>
 <xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi>
 <ahQJ4kuaBKMhj52L@ryzen>
 <3dkicfydmrlm2i6ks34kwjdmlvb22ryftkfw2yj62o4rtj5xvl@f4gby5vlwtdf>
 <F31848F5-5481-4402-9B45-9EC7BCC8B0B6@kernel.org>
 <ll76isrjb62ieiz4vhn3u3upp46vnzed3slpqxnni5hymsc4mw@avbx7k473uo4>
 <F8664D81-EABE-4E36-B0C9-2B0C7FA36DC0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F8664D81-EABE-4E36-B0C9-2B0C7FA36DC0@kernel.org>
X-ClientProxiedBy: TYCP286CA0353.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2f2eca-3e26-4c6b-6b27-08debaef5f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|18002099003|56012099003|22082099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	11mmZbNCecQO4huj9VGcqPMFkNX+aA1HYLi7MvMKpxziIdCAsnO19nYPssbgorBtv8duwxoF1yuCBtJawOWlM9GqkJs4X1OIGoNuC6AcUzb8zfMimkQT2G0/WhETvdyFD7uvtMBhEz/lAxKpWYlsQs3RRDw1piMfEbbGb0d8L7TZd4YU+XwjRD0o0WCMXRjry0OFjWsTq+at1KZwUppcaJDMM/SjaSr4ukrzeI2JzcD1u666caYUOcjJWIfeC68rBPgFcHO3fR3hlcH4oHLkTYeZfhZtDh/MQ/qWLQFytEs2lcD58aLdEPFmbuKIMF9fhRA/pdiigOC7wNzAICQEGLd0Cox+TvBkuJSCY9F+AhndMMpnpVeeWBGSnzxyFBsDUgXn3XtRuEFWs1OwOiwkhcN+9Th0IL8HfgkGGPgKmQ2oUUEedrjGJIwrLmt07rzTwFIVkk79kI+hiNoQPSWqV67c/ezQmTiLOS+/tIOJ1wE8q6YpQ+ruqMXXM0FFwM7AWR8MRzXRaWdtvgX8GqJJBasILOZyREUidUxFflhicKall1rT42jH79eM7PUZny4DrglbRYMQov0M5paHXgMSTZKabTPxsj2gPJzMPEPdFy63yvheLRmR6yxD01BA2g53WVwvD6fI39BWaTTmxqsyn0pWnTfnGYNMvyNZliVMNrkf6smens9qAYVHetnwU0jwwCtMD2GetgeuOPIBFVmMDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(6133799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ISnNCCr5hV1O1N/3jCDJkhH4HrxInx2Hl/nCOeo15K232Fh2n7QtrMBh9aip?=
 =?us-ascii?Q?5k9xOS9CScBZ1LqYQnpZsp/o+UmQNWeDTntQUDY6nqqaLm8bNMUld5Y2o+B0?=
 =?us-ascii?Q?DfkvclTMSDk58RhvJ+mpmT/I4GTGK0rBqQMa1NRizkxo3mArdTKzyym8FPxe?=
 =?us-ascii?Q?b6NCj6kVzeVpC8OGBCXBx7f2I28AEzStjXOdcG5EfKwMg8WWKCdEG8mITXaY?=
 =?us-ascii?Q?FI63oXTYywfS8rRigkH5UpeyjirrwQ8Gp+vk818eaiuKqJa1YI5/uw0O6rK7?=
 =?us-ascii?Q?ZLtW9o4pTwQHyRGjw6401TP8pHZbucqaInw4W3LVlICSO8y2USbm4O7kVoCT?=
 =?us-ascii?Q?5qK+3HT9Js1xzjZjNqmR1D94UxuB1bZ7XhrTNcqrTWQmQrS8otRRCB0Lc836?=
 =?us-ascii?Q?kqq4uUOKGRRv0quRzgrdwu5C2plJNm18M86xmIwN9eUm1aL1cbJibbdqqQs9?=
 =?us-ascii?Q?572WQZg6eXu+2IlERoU4yNRt2TqjSFSlA0lTwJQ1sJmF9qlf+w7/rci2MoCO?=
 =?us-ascii?Q?xNqbbgJsVrEv6r4+r5pRZohFPwSm8vdqpLLMh8lEpdH/Vw4nRL/cYzyuq6yY?=
 =?us-ascii?Q?/FxOZwYt1M2MxJlII9SPPb5i9imNW3zGpkR4cC58bwBUtY9Llkf2F8d+gX2g?=
 =?us-ascii?Q?I7PXgEzZ0fBB5cyPN9rMswnWY1p1vybm2oCsePqYuRVqQlOgj1BWoTZa/qLk?=
 =?us-ascii?Q?S0qX/UEs2L/9gZuxJPkPodX6NJqeysQP5/+wIKm+8pIPZE6Aj0H+SmjsSzW9?=
 =?us-ascii?Q?9m3sITZNkdRS/NGXEm+UBNbkrW0Mi7yIfkHDlBhjsv9ffYKoAW9U2MfihRFH?=
 =?us-ascii?Q?9Iky2HasI+cVpt0yAlwn9daUemUisCRxmpPwwYwxs0AfYJo+z9vHmMAUWZmp?=
 =?us-ascii?Q?5khm1SXn2PKdGEc9m6297kvPaKR3BoFr6rPXcyqiTCmSx5sRWpj4MmM41eXk?=
 =?us-ascii?Q?wax4J+M8oBby/3FshLxx9BJMU6BEk89UQHcnDXKNuzKLp4iV7VKH4cWyB8LT?=
 =?us-ascii?Q?TH5I7YPONxbJJtERN3RLYEZZMWDEt3k1yPa8WVOR3lpF1RNFoGI94bZSk/4i?=
 =?us-ascii?Q?aFYJcZZLfJOKTFkgS5c/9vYkiqfEaZSZND9rJli0BM2ZuDcwDMTiLfLSF/Rb?=
 =?us-ascii?Q?Z8G4wvCV2orm/7B1bqBA4ID8MqEhRhgmzkeGicY3vHvEw+BiHiqrr6a2rVCH?=
 =?us-ascii?Q?/O0hCr2L+jhZg7TqwCft8JeIEEDUH5/ujaorkKMDBnEUCn7XBbVhnjEssmki?=
 =?us-ascii?Q?jzjXgywGW8QRokfSBNiv4RPDJIFiBcoonjfoUYcKpuqYzZ4366O9KBRr7TAI?=
 =?us-ascii?Q?KhfMOZ3Mdi6m7YL1LtOgNx9tESwmt0swNTavfA55ogLuUkS6gaqIrtRYj5Qn?=
 =?us-ascii?Q?t7XwFJXZ7omrejdqRmr7zmCHEE0bb+B1xSbaCSXUyVvrl62xoU0U2PL5rxH/?=
 =?us-ascii?Q?O1vls/1ejPLTbds8GVKeMDQlmqp908il6uOLcxsiNLH9tYooVI/YsNd9kFj5?=
 =?us-ascii?Q?NV9kJQaUVvfZZVwOfjeBwOdsAvjywVyqhoavOsDHqUVVNiPs+ztSzbShITx6?=
 =?us-ascii?Q?6PMoaFaACAJ+hATLyzPCuezBXw11a1pZOiHlbwctxum21OBLfG3og2LYOR/w?=
 =?us-ascii?Q?EzyADw0kaZz5+Nhgv1xVz1/oRg2wLYZACkBiCQcN+ipkSuoYs3nDilgEulu0?=
 =?us-ascii?Q?LyG8QDGIUG5HK9PdUGpRa5U9bKlVg96WrMPQjlmyvaWx2/TZmVSjTU3VmQV8?=
 =?us-ascii?Q?Ylrpv4Q0PgNCysUvIsZPJPumYTLczEEuja7Zth+EN5vtQcIW5XCj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2f2eca-3e26-4c6b-6b27-08debaef5f4f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:23:59.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEI4mkdKsImyIQYrqW+jEeiaBdkeOItGA3ZcPAj8+/vEAkpFcu3uZXLMXnf0opR36NuG7GPASObE/bijymUJmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7008
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10893-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 996B45D124F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:35:06AM +0200, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On 26 May 2026 04:04:07 CEST, Koichiro Den <den@valinux.co.jp> wrote:
> >On Mon, May 25, 2026 at 10:32:06PM +0200, Niklas Cassel wrote:
> >> On 25 May 2026 16:03:35 CEST, Koichiro Den <den@valinux.co.jp> wrote:
> >> >On Mon, May 25, 2026 at 10:35:46AM +0200, Niklas Cassel wrote:
> >> >> On Mon, May 25, 2026 at 04:05:02PM +0900, Koichiro Den wrote:
> >> >> 
> >> >That restriction should be documented with the new NTB transport, which I will
> >> >submit if the direction taken by this series is acceptable.
> >> 
> >> This is easy for me to say, since I am not the NTB maintainer, but it would be nice if we could somehow come up with a design where we don't only support EPCs that have 'max-functions' != 1, because IIRC, most PCI EPCs have 'max-functions' == 1.
> >
> >Yes, that's fair point. As a quick check on v7.1-rc5, among DWC-based EP nodes,
> >only 6 out of 45 set max-functions > 1 (about 13%). Assuming there are no cases
> >where the hardware supports more functions than the DT advertises, that means only
> >about 13% of DWC-based EP instances described in DT could support the "NTB
> >transport backed by PCI EP DMA" use case. If I also count non-DWC EP nodes, I
> >get 15 out of 64 (about 23%).
> 
> The only DMA "backend" added in your 3-part series is the eDMA in DWC-based controllers.
> 
> So if all three of your series lands, then 13% of the DWC-based endpoint controllers can theoretically use this new feature.
> 
> 
> >
> >If supporting single-function EPCs is a requirement, then the separate PCI DMA
> >EPF model is not a good choice for that NTB transport use case. We would need to
> >keep the DMA delegation metadata inside the vNTB function, or use some other
> >single-function design.
> >
> >That is basically option 2 from my earlier mail:
> >https://lore.kernel.org/linux-pci/xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi/
> >
> >    [snip]
> >    2. Treat endpoint DMA as a first-class part of vNTB. The RC-side ntb_hw_epf
> >       would create an auxiliary device, and a new dw-edma-aux driver would create
> >       the delegated DMA channels on the RC side.
> >    
> >       [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
> >       https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp/
> >    
> >       I added an ASCII diagram for the overview as a follow-up comment here:
> >       https://lore.kernel.org/all/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/
> >    [snip]
> >
> >Do you prefer the vNTB-integrated model over this series?
> 
> My take:
> 
> I do think that the design in  this series is more elegant that the vNTB-integrated model.
> 
> However, if the design in this series only supports 13% of DWC-based endpoint controllers, when the vNTB-integrated model can support 100% of DWC-based endpoint controllers...
> 
> What good it is to have an elegant design if in reality, it supports drastically fewer SoCs?
> 
> But please don't listen only to my opinion, Mani is the maintainer, so it would be interesting to hear his thoughts as well.

Yes, I also think the architecture of this series is much cleaner. The option 2
series may look like it overloads and complicates vNTB a bit too much, and the
auxiliary device created from ntb_hw_epf only for the channel delegation purpose
may look awkward to some.

The coverage concern is a real downside of this direction though. This is a
trade-off between a cleaner PCI/DMA model and broader EPC coverage. On my side,
R-Car Gen4+ is the main target, so the multi-function requirement is acceptable.
In that sense, I am also curious whether future DWC-based SoCs will typically
support more than one function or not.

Thanks for sharing your thoughts, Niklas. I would also like to hear Mani's view
on this series vs. previous attempts. Any comments from others are also very
welcome.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas


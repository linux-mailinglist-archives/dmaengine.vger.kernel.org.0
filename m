Return-Path: <dmaengine+bounces-10229-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGrHAKMi+2lvWwMAu9opvQ
	(envelope-from <dmaengine+bounces-10229-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 13:14:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8724D9A2B
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05C3430134BE
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5803F421883;
	Wed,  6 May 2026 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ko0VEGSj"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02B32ABCD;
	Wed,  6 May 2026 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066080; cv=fail; b=Zgvej4EjA0z8qpl5/raEPLyDRAqtrTSaMrEN3f7JdnRIuzomV1ElkaINDPx5qKFcw9CDatneRp4xzOST/pCxk1M2ial15vhsG9VoEkQ5QXy2wPZX1VJ7XFFYBkZs3NuBORa9BwwVgQr8BM0gJPDutQvdAVUYsP5CZRRQSq1ptso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066080; c=relaxed/simple;
	bh=3ZQpXgeTZGpGAcjOelXbNIErVyO911RVYNeAsJCln84=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LWYQ2c7D6Q4mdZkjIzargwZHfpr6cvnAZhEYDmkFK3jXQ7LIB9/VjWsy/Y+xQxob6n72RfnU90dQq4enp4Ghi3OVuAmJrdSL3cU4oq0LqEXkzLBRfgMuApAJhmVgT+w3+sMK5B3AbnRLY3EJnp0BLc+ISudBEfdrO59mxN1RZN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ko0VEGSj; arc=fail smtp.client-ip=52.101.52.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUut4T/Ns2HszNipqOob82r7xsu2/yYXeEc2ubS9vPQR2uyZFZ3+IroMuTDTNMLQDHuCdPrgcA98UfXQ+JiDY4wEpzN34XCu9jbbIa7dqrVh2zaKIbfb3U6BOTbjii8fasGfim7l5/nDXqJTt0k5DbCDm+JYiyiaZV1Cq21Ax9RgxkgXUeEXeV82nH3IXryRTFguHqedWk9wAq4pcs7XUlUGRvTQlVhz1+Ew7PNVK17yiZfywMPhAAR2BGHCP+476CngvFVheIqna7AenX3JORpuMwF0rU4msms50koRsY0Hr8WKrX5GXfQsYnYxSMR6a7CgIWW7+rxc/TJ/QFbOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy1KlAP8oFmJ2jom6NJfOR0MWykD3bW7hoy3v1cLrwM=;
 b=s7tIwiL/ySk1euhOnieiooyMqHIyiq35IkUbbKBRWbIBFeprgYR5jiQEYJHFvpR1QKBZaUblbfbUjscWmupIeDSFc7Mz6qA2UJPbVJvPLD3fzUnJnwiRIPHkKbF2xXu4ikAPyLxlJ7llArL2dzg0aIQgp49AgdEcy+VelB+zwCXGr8PIB27M8D1rPOrTUPkA6nt9LNI/pbvy318SlTIi9obYf0Qato5v0FRQLk3M4kzFN4Kpg7F14lKo7SA7eEJKO+3YmF9yA3oHJPusOvRJ6dH3p4zTjWT5zXaJl7jC/Yy8qq180OVBVTNaMxJjf+JIagKPIS9XPnQZJrfVBUoogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy1KlAP8oFmJ2jom6NJfOR0MWykD3bW7hoy3v1cLrwM=;
 b=ko0VEGSjMGxkeG4wCZfZOlVqxPMLBXm593+4ktAMm3sqST1VBSY6SFcY1NSjonu+kBOYQqoB19+/j+YweIXSYoiR64K3ZpZC6h5SKQManK8jOyL0EOZfKMHv5JJg6qbgipjKJBRZ7leQcODzZM9nPjB/adgcv6uopikN44NoCZ8=
Received: from PH7PR13CA0012.namprd13.prod.outlook.com (2603:10b6:510:174::18)
 by CY5PR10MB6192.namprd10.prod.outlook.com (2603:10b6:930:30::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 11:14:36 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::f2) by PH7PR13CA0012.outlook.office365.com
 (2603:10b6:510:174::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Wed,
 6 May 2026 11:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 11:14:34 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 06:14:32 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 06:14:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 6 May 2026 06:14:32 -0500
Received: from [10.249.131.170] ([10.249.131.170])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646BETqG1240870;
	Wed, 6 May 2026 06:14:29 -0500
Message-ID: <0c1d1edb-40bd-4784-a308-7d2308b466af@ti.com>
Date: Wed, 6 May 2026 16:44:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: dmaengine/ti: Remove myself and add Vignesh
 as maintainer
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <Frank.Li@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nm@ti.com>
References: <20260505164605.15878-1-peter.ujfalusi@gmail.com>
Content-Language: en-US
From: Vignesh Raghanvendra <vigneshr@ti.com>
In-Reply-To: <20260505164605.15878-1-peter.ujfalusi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CY5PR10MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5233f0-582f-4795-ae4f-08deab60a794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OH48RsrIIy5O5a8hrCLhzqpdy46FHnIvqZ/ADJkYJ2SGKunwllFEizJhcy+2Axh5+/XWEhpgc8vG96xif9n5MHltp/VKb62HLeJ4Ttm4+AEv5heA7LnMzGZHRC+3Y1gWihkhnEcVyQS5fYySUL6gzNWHKxsiEmA8VNlbVrka/5hnHGWZmEP/TOoNclZf4OtWctZ8AVpC5hsnH4Qj9cgNT2/vPrfuRy6q2weIZRftX2m2jfhfnK6asrUufPCRqhvO8jFVNjJyAQ9+birhG30QNMkiEi5yqGN/qv28cW5pTPVZ27JLxfw9yVEL2czebXbcwTO0TDiIb2vep5NLCtRozEi3T1sGmSTpkKzxmB4BKIG/EH21yAJErdY+wx9YH5c8FsNIsIj+rFLWH6tjOXVPoV9Dqs4DmD78Uhdve63u1utGEtyVdDvCHjt4Hwjlo3fwVW2O+0XEM8Qt5sFezSEQ9s3f5wbJETdHQp6SQ9Ha3cDhXBwWvQNCUnuBDeQGz5jXKFnD9ol0n8n9g9o458Ws2/BYKSpb2LuIyF/DihPgEZQCH0kcqt8o+18m0tSPEkJk3IXdAcax4PZRrkLXWsj1cOOajDyjesvfALtMcA03KkJPJ0GKv5yXSm6HPg2UhpAFwgo8lHjuT6l5AiTXy3nwFzjQ7jDYoMYBJ9j/ukWCOAFgZxlUD+ny2Wh+PExBkCdjHb/k0dBDp1O2JnH4Q1k2Q7bvuPMAA7ZYAaDqKiIrLXg=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kc3x800ZxtjwemXieVUQOvduZxBBDwQ96hXGzsoay0Mn+bHedyHX9e+7QG7cTPQPpYEPLFe5NUDgesXy1Ey2PQyQP5AP0ZgC16O3SmFUhJz6cxY7D13Ge14FkjaggkQxsLyv1dMBGft3gXgyP+ofhirr+lsIGpUl1WWsSm8VOydowz7CoQlUZFTygctX5D2IvaX7j97BuYC9o0I+CBxm9kCl0Vx4gzJXBr8BO7FZMG0xHdX4K09AmKCGY7Eenp3tzASOy3uUEQDbiO8uZkzFx7usiknvCITh6kzr54iPkjFjEfb1MJqByq52hdwsL1BpEph3P3sq9gY147mPB4ZGOcUWxXorTwOGDUjlRh7fKABGDGESF0kNP1GDVF8gUkgLqE2Wv3l6iDTAJeIjIy0/UvMYc/t58IF0CdpsxDfWT0ozbWW4LaLsCTx611dtSbEh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 11:14:34.9071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5233f0-582f-4795-ae4f-08deab60a794
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6192
X-Rspamd-Queue-Id: 5B8724D9A2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-10229-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

Hi Peter,

On 05/05/26 10:16 pm, Peter Ujfalusi wrote:
> As I cannot spend adequate time to fulfill my role as maintainer for the
> TI DMA drivers, it is for the better if I resign and hand over the role
> to Vignesh Raghavendra.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> ---

Thanks for all the contributions over the many years!

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0dfad67f66c0..f1575f1d2d8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26408,7 +26408,7 @@ F:	sound/soc/codecs/tlv320*.*
>  F:	sound/soc/codecs/tpa6130a2.*
>  
>  TEXAS INSTRUMENTS DMA DRIVERS
> -M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
> +M:	Vignesh Raghavendra <vigneshr@ti.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt


Regards
Vignesh


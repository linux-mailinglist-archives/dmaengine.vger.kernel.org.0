Return-Path: <dmaengine+bounces-10969-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAE5M6gsFmqdigcAu9opvQ
	(envelope-from <dmaengine+bounces-10969-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 01:28:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 326955DD8CB
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 01:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBEE303FF92
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78C3AB274;
	Tue, 26 May 2026 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nCbGpq9M"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964953C5856;
	Tue, 26 May 2026 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838118; cv=fail; b=depBGFO7n6D6DPompqfanFyb93m7lZKPTVH+JXO3j7ypgdZwf6fDVknBQ2ecFHawhL2MJaKOZrhkoHjGIiSrIG3d6kgBy3VlHywkBpw/4BTGN8P6ss6Jib2DiSktXWH0jh+MX36qfYQPYrl5IgVgm+R3HTKegGmhWCRNM73XHKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838118; c=relaxed/simple;
	bh=cXkOYu/LtRo+n5w6aOhtMKCbnh9f9UvHPYeAq1VOSZc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S16NHs2VMEwwK5dcIiJW3Vv8UW4942uT12k0Pu3WNaOqeCeRInc8be4az1TnYOEwdqmKXAf/he98Vus/feCw7rP1opZ45t+C1wrjKHYkIE0iOtHnSSi+LOSZScYgvfkhx7uZmeX0WyktlaZN8PGXNLYGkXrgBihB+CAoqqOtmE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nCbGpq9M; arc=fail smtp.client-ip=52.101.56.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3D+Qt97FSwVflhf9m0k0Yq02FvHgP40/gnXNb/0ccPtivWwRcGGDvasxcTLxliBS0mizMuUdnBJlJNGifiMZcg0Sb9uz9rUMZGRCHuHQD6SMpZdDgZV9t+RHudQgbWL9yOnsFbzi/w+5vb1zrH9WMX6/m1djjy+rLXZWP9izhaVjDZsYjY4iJNmjoPryLxhxAB4/32dahhmNPt6nqWdMWydLm/zAauBMGNYcxfaC/iLbp/YJkR22KL5afO6qNXqQ4dqRhEWVYAOANgnetv0QlKaag+oI/d4vibp4Mqo8Kb8DRtbtSG2pVtU5sbezz3QlsIUA4zEa6UPmPZYjDLaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmACQlURVVDKDCmjQ8l+K+JckICa9Ag3uOUEUEyQMbw=;
 b=Ofb2nfkpAbWzxpt5U+FxXxC4PLyhAA/4ZYnxwq7SMnZORMujjAw3ttUCON3Nem5BprvH3uROppaQdRkEim+8E30hB23CPz6ypLAEwFnfzM+VZJmotXr5d7+kebjdva5St8t86Gvedyqudy6k4g7WCaXyUrGEzAKt+xRXdsQiHufgVQadS7zCY3KU50N8j8tXxDIMgCzpBXadEQbAmpLUmosJ/bNPO015DxW/wID8KWRk0ShmpzIUb+ZU+gt96PldbVVTqoaVhdb0jE9OfwsD10qZtGw8K3zMf9O+yU+Z6SpScR8Jgw7aO5LygqEg0LRSOep/6oW52/hwe6mNK/SvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmACQlURVVDKDCmjQ8l+K+JckICa9Ag3uOUEUEyQMbw=;
 b=nCbGpq9MvIQQ6C7Q23vG9RMiNdFM3Zmat1GIbsaEtJViv5rv9PglylAlUcwftn8S/hh8ErTe+dhJfUbKUKovjLo7C6reiAFRupyNQHI3pZ7P/LcJSQRxcX9FHCJS7bWmB1hu9Fw5QmF5PFU3sTejgSc0hYjWr9OT4D4OteLdH+Y=
Received: from PH8P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::7)
 by CH2PR12MB9495.namprd12.prod.outlook.com (2603:10b6:610:27d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 23:28:31 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:2d8:cafe::ae) by PH8P221CA0022.outlook.office365.com
 (2603:10b6:510:2d8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 23:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Tue, 26 May 2026 23:28:30 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 18:28:29 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: <sashiko-reviews@lists.linux.dev>, Nathan Lynch via B4 Relay
	<devnull+nathan.lynch.amd.com@kernel.org>
CC: <linux-pci@vger.kernel.org>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 03/23] dmaengine: sdxi: Add PCI initialization
In-Reply-To: <20260513000526.55647C2BCB0@smtp.kernel.org>
References: <20260511-sdxi-base-v2-3-889cfed17e3f@amd.com>
 <20260513000526.55647C2BCB0@smtp.kernel.org>
Date: Tue, 26 May 2026 18:28:28 -0500
Message-ID: <87cxyh92eb.fsf@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|CH2PR12MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0c9dcb-cf80-462c-f85f-08debb7e7f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	+fLh040c3f5YgK3xE/EfIq72mURe0FDy5tc9rJ3NgoQrSiv8jZajmvmRRavg61jucG/V+0IkNaEL7Kf1ih+xedbphPfHrUOKK60z65I8i6Dts5Tn3N9jmS7Y+Dw4vMfH/1hMgpRZIVTpdhPBGKIUa6cXTy4WaZciBTbCgahzvTld4JaWCZ7JJ1WJ+exRJugk3PA769wgBXRKRlStp1fDH8dZ26oJwXrJ6oUURjOk3JWsKLzPcVYTfPmNVnESazTs7o/jsvkKu9+fAVE/e74CUCYS/qd0P+cH28p0Iu/9ZqUUhs1e1+oarlv4fV06d3FIgZEWJZRzHLrrfLjUbe5HZLlL1j9ZVJDeIqAS+tk6eAyB5/ufPWSwa3WZyLa4rGkQObviX/LrH76+0qYaKkUHDWGsq7QeEOvN9IuDFvYQfedIS3tNTJt5Q66Nt/r+XGT+EZzZxen1b1fwGe8x1YfpIqLtHwkTvL7cOBP+2Z33rXooGktUbn+SXOhRkwgNLsw4lQqT74UTLzAqPM1OJGrhG7l5isf+Z63+Ls9uZUG+Ji9vwX1o5xA/3Sr4cS85pq9x4J7HxisCaIr/Ze7/DnsNCpGsFWEJ2ysxSRyJg6C2tEz8qGIcmcAsKbC1JwZTxLNUCmRQA2L5xHHgKRo8zOwPOy5+YR8A9YYudiPHQBEjct8qdhhVSpTaoSRKAdLSCeJi1eLnEILuFjOem3H8IkEC4TvtGmZB30DGxcycb2k3MvE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KO/6LdTqflZ6QiAnF/EgGPNta7ijYY0veadxM0rkcFKoTU9/NrZemN63JtFtNB4N7HUw8LlTtTv0f9/4ysbmlRiHzvQv9hiiCUtS8AGZwJ47UMXSbHyx0uK/Plgk0p6pBHkBuYfFJIsSTZD3uf8llgrXVCmAZV5i8CJkPgwILzjH0KZsB0sfn9k4heGIrCjSBSNtE8AOVraOFkNLc+ayct1KbDhCMD2sgKoGYF/39QwQChks03TTzdWNPY7LD9KfglpK5ceoAaeHaH9mKZnX2RS0wQridum7tdwOGBsyv2Rn+fQQ5+qcmNcBAzXp+t1WBKMYiyZWRf0EiWF0mDNg/odZtiUhDiWQtSj7k3v5Udqj9FqfNxgxVuP5vLTsFU0FPfhLuYAZUcyMoUycdZLMbS4JL889bh3iDeKn01k5xjCS2ddjcD2btb77LhvcyAmb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 23:28:30.5387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0c9dcb-cf80-462c-f85f-08debb7e7f25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9495
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-10969-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,amd.com:mid,amd.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 326955DD8CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sashiko-bot@kernel.org writes:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The Kconfig symbol `CONFIG_SDXI` lacks a dependency on `PCI` or `PCI_MSI`, and the Makefile conditionally links `pci.o` using `sdxi-$(CONFIG_PCI_MSI) += pci.o`.
> - [Low] The return value of `dma_set_mask_and_coherent()` is ignored in `sdxi_pci_init()`.
> --
>
> commit bdb690a4c497e7a353f0143e03e32ba75daa6013
> Author: Nathan Lynch <nathan.lynch@amd.com>
>
> dmaengine: sdxi: Add PCI initialization
>
> This commit adds PCI initialization to bind an SDXI device via the class
> code. It maps the control registers and doorbell region, managing resources
> with devres and registering the device with the generic SDXI core.
>
>> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
>> new file mode 100644
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_SDXI) += sdxi.o
>> +
>> +sdxi-objs += device.o
>> +
>> +sdxi-$(CONFIG_PCI_MSI) += pci.o
>
> If CONFIG_SDXI is enabled but CONFIG_PCI_MSI is disabled, pci.o is omitted
> from the build. Because pci.c is the only file containing the driver
> registration macro (module_pci_driver) and the module license declaration,
> would this result in a module that lacks an initialization entry point and
> fails to load properly while also tainting the kernel?

I guess so. This is just to allow build coverage without PCI since SDXI
doesn't strictly require it. Maybe there should be two modules: one for
the PCI driver, which depends on another containing the bus-agnostic
code.

>
> [ ... ]
>
>> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/pci.c
> [ ... ]
>> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
>> +{
>> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	ret = pcim_enable_device(pdev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to enable device\n");
>> +
>> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>
> The return value of dma_set_mask_and_coherent() is ignored here. If the
> platform or IOMMU does not support 64-bit DMA, this function returns an error
> code and leaves the device's DMA mask at its default 32-bit value.
>
> Is it expected to proceed without handling the fallback or logging a
> warning?

Review comments on v1 indicated the check isn't needed when the mask
argument is >=32:

https://lore.kernel.org/dmaengine/aeXJhhPgfGjGZa__@lizhi-Precision-Tower-5810/

And the DMA-API documentation appears to agree, although I find it a
little hard to follow:

https://docs.kernel.org/7.0/core-api/dma-api-howto.html#dma-addressing-capabilities

Generally I think it's bad to ignore the return value of an API that's
known to be fallible for some inputs/circumstances, even when using an
input known to render it infallible. Ideally there would be a separate
API (dma_upgrade_mask_* or something) with void return type that could
be used instead.

Anyway, I don't plan to add the error checking back.


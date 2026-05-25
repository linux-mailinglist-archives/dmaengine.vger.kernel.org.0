Return-Path: <dmaengine+bounces-10836-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBZEMvT1E2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10836-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:10:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FDA5C6F44
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08B383011A67
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDBE3C0624;
	Mon, 25 May 2026 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Xct1kSwr"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5153C0621;
	Mon, 25 May 2026 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693031; cv=fail; b=j8yZD/DNJKdXbElNmF6dRZb46Jd6kgrVy+M9ZXz336J3r5yhEcW7XA/jrLE7Ak9nF/sw4EJs1qf7cX8lYDrwgl4EPv6wclN2MdsOtSHc/4odscgyv8AMUXnlUY27+7eurrQw+M6bcfbzhJVhGhytR1LOTBjg58rztz91Hc0Fwas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693031; c=relaxed/simple;
	bh=NgthwP+aVYYPA9/dcVIWdg3SD0opIMlddn4g/b/O3Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMu2rTOxHjWazd6yb+9CaJKmHGN5AQOAfwv35CXcbLpPIMHbrMV5os0fSJaMOedI3xZIBPFj3giSawyd3adR7l/0B1gLtTAMbTtz0UHWTfkYNq9oX4UMg4T0brGLx7HOYAFgzjZb4osCTrEbUSDN60HcRCcxiEhmzrH8YoKYZPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Xct1kSwr; arc=fail smtp.client-ip=52.101.56.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfayba/bs24PQdz1Al0kH8HysW4n6zPKXm/xtfNP8zG4vjiudYo8nQ3DsNDRLuoFr1Ck95TWQ3zlOgUgmNEsQW0r+K8zH+meb87kRl9rFQC9mv8I8ecIj8phxsfKJZcoLohlExupFyyOs/8eRVYrlHvwP/PzRdny/IDPHsG2q6UbfepZ0xiSjkMpoS0HknD5YCFQbI0J4mwX9w1tW1pMuBZS4qtF9gQlqBcRduVUzdc9fr3KxDJOdveRvQzBgzSXmAnx0XueXnghwFvjbGkA7KggQWYTx7+cXD8lJgyPIy223rFsZXluSFldOEAqKebAjz1roEz7QAmqHfhJ1qhAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw2cE/0PkZzDCcGZzKQIbiYTWfNmxH3PgBlZNq19DKs=;
 b=Jfw5jeyU91xTriYtzmlHMlm4ljz4D73OB8VY17kpFQVKh2aEKGLIJL7WIkPDY6I56ejepjoNZOoaBLx1dGPad/Bf+jOVSL7gTWnPMXy1E0+EKW+SiSd21VxswTSJnnQx3SaODOTycS4ZFX+i6wnIYBTLM9nU8C4mYDvvdv7hu8/c6Hz+zBU/X5TszAtG94uIf7BnNYY74EDjpiIip1m5jTFUGaT3mlNknFawJlLL7Nczm6jAHO4m/LVBW1btTe2EjzehR+HJpGveWfBzxVfEr18AyEf/l/xSrrVA0Zcp4s4Q3HAxO2FE2R9ELTpbiHu4pCoxp+xp1S8h36CSB5pa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw2cE/0PkZzDCcGZzKQIbiYTWfNmxH3PgBlZNq19DKs=;
 b=Xct1kSwr5dvexw+aEbDtTbGR0cB/Mx8itruAO+A0JNXsFNXbCNpNe7B+DaR8GcP1bAyRIIHWVWC77qGnwnImdaqSt/pG+7g678oECTYe5Yeanatfjq32gbQ+Iv3i8t5M6ODmGHECaU5eSKW+jUH1FdNfwjRpKUm1SzuaulRKObRa0yVXEJ9NMlEmzIGoABQg2RoI0B8FRmw7g3Z7+MlxpeuAU8PdbM2r43yebu3850IMfDsdNuNTiez0T1p3vxC1A3BHybLTyDHT6ee/5sV+BlbfrbSeK3jksopb5lkqVBCPGDaTluRXohvxzHpkhwIftBbvAukJ/F3gpeHTXwyzPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA3PR03MB8456.namprd03.prod.outlook.com (2603:10b6:208:53c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 07:10:25 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 07:10:25 +0000
From: tze.yee.ng@altera.com
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tze Yee Ng <tze.yee.ng@altera.com>,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Subject: [PATCH v2 2/2] dmaengine: dw-axi-dmac: fix PM for system sleep and channel alloc
Date: Mon, 25 May 2026 00:10:22 -0700
Message-ID: <18bf778a3a1cc2f377ef8eb0d1508d8ac6371896.1779688569.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1779688569.git.tze.yee.ng@altera.com>
References: <cover.1779688569.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::22) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA3PR03MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: b16ef17e-9c2b-4949-69b9-08deba2cb14c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7ToblRRu0yyhS5R7kmlmZKJnQUA863tHmXRaq9A9Qr5QnWQHJeC3iTx1eCpV5kFn7z2YxN/sABdnCKoYox9XpC7wVUVttOdepeCbLqUdfG1F11WMUHnBs8oELi97AIQZeRqGF9PJbXZo6jF4X7zjnDIr4u7JzXtjaMS6vlxgFh2k8TUJCsTs19NzFRMKQadaiUjboUvqkxiIrSNQAoW+xsfK568po9PCUsjF62A65BWF8tdFRGB1l94IX7R9P9M5R51dDntF9zR++bA2HieWaoMFw3/8vIg/PDyx+4iGuU9AMCaCC/JiNLwAn1et3PQpR2hnlMTkxjAxKz8bF7YtySw1dCMaLc+W7S18joesJo5xNn7zyWX5XCO9rh9vSRjjlOySOBdps8bdAMbHDGXS2gLCBvLbZHL9PFSnJYCXbGoRrenA1/OGe0s299fNONW7MluWYdtI8WRzHh4J0NaojsGE8dU4LZ8eI9tGV85FTNwxxRMPYOsDf9aTTxGu5+SQq8loKlsBZ1fWXQ3J44SgFovOHK3x6beUtqRs9jDdTCRnO2JoQ5TxgKUGFVXGbavVZlxg/8Kwd7CNcGe4qaOM3FjO4f2Gf5Gwiy44eGXGMB815zJTzZqt/qrNBZ7XVQeFjZ69aaS1UZW3jOSCqRtoeE/n1rgGKCRo+HKHT4e0kNyVKsRkc1lEizqEg7OqHDI+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HnqzCKAswFXSxsA+CAFMJhcmVtvcxdX/5wngO44p7Pyn7xUzMF+EPoPw1+lE?=
 =?us-ascii?Q?zGG853qh67X3y54vGjjp0PZxZvHq1sZHDoDaMicV4oiPZGUeLb43WXOK4ZlQ?=
 =?us-ascii?Q?rFvZMvoo0aVa5LLy5aOztjeRIkDIgG02BIeecvqjNR8u6LeQaeOP4FSxzT4B?=
 =?us-ascii?Q?Y7H32+fi7A4fTJLgfo9nkXC+A13DteEM0BfjSKyV5VYJYWyfrh4GOziGQbL0?=
 =?us-ascii?Q?nAn+DUFt/IRDAf25usiS1tY5EZf485DKL8astb7qjaR2SV4PVu4LJF/C1yXI?=
 =?us-ascii?Q?C3Jfq4ntyjgmWCtnZQ+5CYZ+Gu0UuspsoXiL5u7Y0IJsYEnyztTTxTBqaEi1?=
 =?us-ascii?Q?watFU6U2R0A8/7lul9d3vpmCa5d3zgCoS7N+jBJWg/RgtjRw9EKQxe708w78?=
 =?us-ascii?Q?T3RRmeJkjUa1NVGYchY3BCKHrZvjvzfqmg/HShowGnbOv4ivfvgXEi0fsIl1?=
 =?us-ascii?Q?M7qepYzVyIGEdZHCJvUEk6p733J7nQQQLQhVH2C4qTFIO0MGsIp9F6/qa76w?=
 =?us-ascii?Q?SKt2iDWSltZkwdr3cdcrB+DPDBW88mX77sJ666UWwEKB4J6FfUxm3f3B37nb?=
 =?us-ascii?Q?OKWAh3oV2KMW1Hux5pKkf8Ij2MK5W+FKz2JZLgrJOPksb7UmHV7oRWr9+ZEF?=
 =?us-ascii?Q?AYiEx3zQPVaMVXk197WBuWExDzx4Tnj6/ce5taYRURU505zvJqkknoTBRk8k?=
 =?us-ascii?Q?gEYQ1G26BjaiczH8fuP9MjMxk8tnzAX0scJCnn8kpthht/okJyh11nr4y4/V?=
 =?us-ascii?Q?5+u9F/7DL7NhYyRk0De60iNKjSxxV1Q7hkXAwWJu/MOrCV18rKflktUgEHD/?=
 =?us-ascii?Q?Nz+fS9W5jXLPbI6juQlGZtgQSj8kee8xRnWDELcw+qGELux/SCrHfqzFcJKY?=
 =?us-ascii?Q?b0gJygfthZjVlWlUB73FbLWNfr+8ngH0iADID39ebwS1oelbm0YU8+voaZrI?=
 =?us-ascii?Q?DWkoF7vvZlBwaqJ7yxwoEr8asT0dvbN7lTQfVPffvfClX9/BSqFcY4jBcJwC?=
 =?us-ascii?Q?X0A+ahOt1zaVJ0rqqZ8sJDUa4nplwog2AUebpnJsMTkCcHb70pit4H4Aq+0H?=
 =?us-ascii?Q?SKMUvPA/UQl3Hq6D9ay3a17sDZsx2iMMNcN+3J9QkL0brDMUKEAgb35FSCuH?=
 =?us-ascii?Q?hsWSMuyiPhzGbptciiC2A5wVF11j1pxw8qDDHULDo+n4mbOGThY1+fV/SDgc?=
 =?us-ascii?Q?EpH92H2Q+IlBWsGI48IwccE5V9WRnfmIOTAqCF5oLkHJK9/GUeprFxHX6KFr?=
 =?us-ascii?Q?X/11f/HcLqLwE9rEMVgewd5XT8Idygk9VYucPVsDr9wu3dax3dTntL7LtxXs?=
 =?us-ascii?Q?TE2Ki0QusgOBVSuxjamcmPS5uiGlFJEnWvVTvDmgM2E7whDssNFGCnJSsD6F?=
 =?us-ascii?Q?ovWAru0i2wNPKEqEg+q4M8tAUHDokdRzAOnFz67R0hU8CfQgZLpe89uOqzao?=
 =?us-ascii?Q?ZvrnqoTS1EgVrEYMfDwxjoSVDciMHT59rjQKg6FO8DBkRC0M3WiEPZxBioyE?=
 =?us-ascii?Q?NsMJc2umE3XkjvZl/7AdImJnbEm3RE2z5dCYX7lzrEjoi8kmY4xNg5wg2eV5?=
 =?us-ascii?Q?vZlaZRxO0xX541E+tdFvsPzgJqHm8mx9ttZfuxBHDRzFKSzcPdwjWJFtxq6E?=
 =?us-ascii?Q?AoWl8eMlUDD60yT0TMjK86PohzzTS/44jSw/xUImHepQhNPhTx+R9dFZF01n?=
 =?us-ascii?Q?gpZcl+k8a/zYsZoXYywkvSTNeq5y/bmvu9AToN4r7pxKhJic4ZaBEh0vMs2S?=
 =?us-ascii?Q?iyzuJCQ34Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16ef17e-9c2b-4949-69b9-08deba2cb14c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 07:10:25.0301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piuDo+FpFiITs1oFXHkvuQKYhEHWA84Qfvg5hNlxGv/BcdJlpOYPR1F6EOkExsfyx1G5NKjxaLnF+G5ZQIn5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8456
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10836-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Queue-Id: 69FDA5C6F44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tze Yee Ng <tze.yee.ng@altera.com>

The driver only had runtime PM callbacks. If a channel stayed allocated
across system suspend/resume, the runtime usage count could remain
non-zero while hardware state (DMAC_CFG, clocks) was lost, and
axi_dma_runtime_resume() would not run to restore it.

Add system-sleep PM ops that use pm_runtime_force_suspend() and
pm_runtime_force_resume() so suspend/resume reuses the existing
axi_dma_suspend() and axi_dma_resume() paths.

Replace pm_runtime_get() with pm_runtime_resume_and_get() in
dma_chan_alloc_chan_resources() so clocks are enabled before a client
can immediately submit a transfer and touch MMIO.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index f7a50f470461..bcefaff03b5c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -516,11 +516,17 @@ static void dw_axi_dma_synchronize(struct dma_chan *dchan)
 static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(chan->chip->dev);
+	if (ret < 0)
+		return ret;
 
 	/* ASSERT: channel is idle */
 	if (axi_chan_is_hw_enable(chan)) {
 		dev_err(chan2dev(chan), "%s is non-idle!\n",
 			axi_chan_name(chan));
+		pm_runtime_put(chan->chip->dev);
 		return -EBUSY;
 	}
 
@@ -531,12 +537,11 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 					  64, 0);
 	if (!chan->desc_pool) {
 		dev_err(chan2dev(chan), "No memory for descriptors\n");
+		pm_runtime_put(chan->chip->dev);
 		return -ENOMEM;
 	}
 	dev_vdbg(dchan2dev(dchan), "%s: allocating\n", axi_chan_name(chan));
 
-	pm_runtime_get(chan->chip->dev);
-
 	return 0;
 }
 
@@ -1663,6 +1668,8 @@ static void dw_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops dw_axi_dma_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
 };
 
-- 
2.43.7



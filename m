Return-Path: <dmaengine+bounces-11770-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dzWAN+QKPGp7jAgAu9opvQ
	(envelope-from <dmaengine+bounces-11770-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 18:50:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD66C0194
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 18:50:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="LW+5/IMk";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11770-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11770-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14BEB30060A8
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFB433ADA3;
	Wed, 24 Jun 2026 16:50:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561C1E1A17;
	Wed, 24 Jun 2026 16:49:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319800; cv=fail; b=XQr4rI0uR/BMisNqM3FazgorkQ9xaUa+2S5V9cT0fW7sLFnDV+ajBSs44b7mETm5v9FfjNU0MzxQQQfwaQNOHtcKpcNlRxKIaEq3Ra86fsMkMcpx+7pzQMvB3bQO76lNfUqiYTtUzTxrPLSa1ctPYRDeL3TzOmM8rs36AEiNTGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319800; c=relaxed/simple;
	bh=W3WVmGQAun057OaZVKhOZVX3UKd4Lvcv6G6wFiM5DgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a0Ee1H5wCNFJ+3n4stM1l9CQtteq5me4FSZhMmLQmvZQM4vxUZZWn/3+BCmzzgrUYSjX+sL5Wr94fYNPWyqSv//fX2DNRQgZZwWGR2oUHqTN3nl30jfN+nNr3VY2T6gWKodrfyn4TUXwPNK3vKiXl7wes/+SPdsiKrWkAZVc/3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LW+5/IMk reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvQciDPTCcuHyHzafYSLruoXkR7o9d+5t87C2oKHThuJ9ovo8gvm0S9WYoOq9nlP759eAyh1CXRR1Xd+PJJgctS6s6/2CEAqzdFNb8EELIu/g/533+ZYz4k+eXoevWjd47xpMMx2360bawvv7uWGLvM1qdgBjnxurGCDM12HC3S9RsnwnxeCCnqI8BjL5BbECqozWbQhipiTIsZFnmEHXu+I/UwReu+gHqxgm1VCUk1ie69siQSBqb8N0TkdDw1Q/tee2gbZg74tRP1vvARMC/jIWjvLrsTgIMdzg0e0Y2xfmahhdA6NH+UvuNEa3ANpq32IsuJCSlPbCxAblEAi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+r9Z0IiR7DvkXiQ+WAPskzBhfIgrx43Vh3wsaSIKtQ=;
 b=mlo8VSc2AsuY7O4S/dvhM6o1xn4MSoZ4sRLqQlf1Ev28RQ/Q859DWh5lCKpudi0fDiWQ9A50K7jg1lQn7CFH/y7cLhYV+PkYkox7Yt7HcJrWhpIOu/dsMCreF80E7KxCtV8xbA6OHCKal9JGmRzNV16r86apbkkjT403h7K++2McZGESpXCYyNlk/mlJVFy5o7JXSQWmwXV6oNzDwAle827qCJugVDpATl9wCxVj7TQdCp5zXox67+gwLeuAh3UMJmYuQ2LBRYc5S0XQ/Mv0CD2fa54I6wnEeZv3SkvWGhx/Mvea3E2t4NVZjxPiuDawXYosQ4hZJ/zcDlbHOtf6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+r9Z0IiR7DvkXiQ+WAPskzBhfIgrx43Vh3wsaSIKtQ=;
 b=LW+5/IMkATZsVwNVdFnMIXJ23TH67fGRncezDOWlK/KETeRd3aKX9P+Qfbw+WZ+bL1etanxvzZsFK5q1cJ8G9nsK2YYXGUfzr6rDtAMvZc+DgD9ZtZN8p2tt1prgY4g5YOuuYQ4ezm+L+NadVDU8Wj/Z6WJNwauJNbAsa9GlTpDHY5s7T/he+RupcqERGpR0i+ZlGioNT/paWATgO6zIo22Zf+IBCeZ6GDz3B451P2gPmy/NFEEV1lH1FJfQPDCcW9cXaHgfWbi+QzIt8tRkRLe84SUP6+xuHnlHFob6LCeoHJRQrQaTIfcNjYBQmp13UPIwvQNaFVfxhVoVGDDUHQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB12009.eurprd04.prod.outlook.com (2603:10a6:10:641::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 16:49:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 16:49:56 +0000
Date: Wed, 24 Jun 2026 11:49:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com,
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajwKq0CB8sGdvvcO@SMW015318>
References: <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
 <ajpYvzlHSPiJRvnX@nsa>
 <ajpfmQ6JID5rHLMF@ashevche-desk.local>
 <ajv4NVSmSR_dn9CJ@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajv4NVSmSR_dn9CJ@nsa>
X-ClientProxiedBy: SA0PR11CA0200.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB12009:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d791252-3718-4df8-a3f7-08ded2109ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	TfziB35f40V+6Qph31x5VM3dksGcIFpjV11kwgBkz5GszLxrQ/DosF3z4UGalSGCIoWjMALWlazKc4ern+fCoQnvlpZP1ts0rTDx39OheQDqKfrji4fEzkSK8ZFgcz+n8E91mpH3eSpRobg458ESiJQVK/osuHF9tOQok2w6Wo1xJ4FDthbpNwCa5St+pTqXv6YFjdgGsGa415wKujNKVHy+9tmbaCVOXcCCxN9CXbn6J1zNjZp4IuKCu3o0zTI1P19pGxqLe2gTYyHvuIJpGwhsG9CLoY755VeRT31KynAcmMKWLTIAgTKvlmACuR7wGVoHYIUcUMTnPb+MsSIxp9W8t14mG1S6mSw0odLZLBr8frKJXop+Fl5ekj3zM0Sa3Hdp5wfj/8bFVAu0LQpAKOHSGIrWcCpaG1hwljROTiq6rgMcrXKwKOw2to2VFKpRsC+sZdSOu7eAfL/djKW7/Qc/kRjnrM/ls5O0jhLAvFZS6ahFKyDkiRNCRjhxZdAWCYMpdbOD37zxKOF5eeGvAlKT9SPYCt9+tZHDdb17h7rt9TgD4CuEW54MvIIESqJDd00O0W/bKBnKvTRgpx+kXKwx5vukChooPlM3D23ZII0pQf6q/dFuPCucxgR/CG5NaaEawu+SVmSXt2f/DTF/t9cXOvrxezvmAEqKUTL5HZA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?q9urDjwASnzP5pGiVIf7MGKk8lCTOk6HpWm71VF1VtBjLaD3ivNNr7SbEM?=
 =?iso-8859-1?Q?eJt6AhUXhG3QkX7ln1QljZiF+ZdLw2L9D6N0PyuS0LhqY50NF4LXUmrA9Y?=
 =?iso-8859-1?Q?VhdVYDDXq8nToPEkvkuot3dP4crRpfao68VrOaicGskkBBrFUhGotVGg9u?=
 =?iso-8859-1?Q?/mRnlcgZg2VdUvFwiVKnxo6JupxQV2d//DMpv6WVV55necRyHybbVyaBQb?=
 =?iso-8859-1?Q?9czGFP8k1LHouNEobLQFO3AybobufcXYTr3zOhKzJSpfchZSxVNTkAc9BS?=
 =?iso-8859-1?Q?BiSzIKJ4S4226mYhM/u5RlQe2Q0ipM8Wxuug1bgoBl3BZOYhzaXtWPKQap?=
 =?iso-8859-1?Q?m5QrKtjtHKelzWd3CRD5pMU+jEbQbsYYYR0TrrYwMKTXCr9DAF9Ag9P4K6?=
 =?iso-8859-1?Q?cuVV6oUokD5KmeW3q7lg24U3TRmGHOQKxlwd9S8sb16Bx97aWJyUMebhZn?=
 =?iso-8859-1?Q?8cL1MKUIJEZpllNq6i60dWqIsJ/q83Ufw3CyqW6T6Q5LkoFV2oVWcHIdNZ?=
 =?iso-8859-1?Q?Sd56DE5fFXuSLeSx2SQzhOMmAxxFnGcGykb4IY41sIeGOCZRTdgIx2lZ19?=
 =?iso-8859-1?Q?wmpkiHd/Q9uo6TOs+mGw+R1aJk0nEMryBmIpoG6HdxDD5uZ/oTQLOgR5a0?=
 =?iso-8859-1?Q?AFH3kJurtemgTxKdI/PeAGsNzD4zqW2K72tl5scYoUKpIRye0ZNjyVBaYl?=
 =?iso-8859-1?Q?VLN7ggPLwsFWMIAuygK6VDMKKTnyJhq2mifnEr84T1QgLCWYC/R8EY5+AC?=
 =?iso-8859-1?Q?lWJYdp3DgAsiq8fKbS4qfFFjoYdrpKlqqDqRx00J/3d+t26W7olb0HcxNr?=
 =?iso-8859-1?Q?+YYYSq2xj0zQ9gmMNMc3FZkFMmcwA8+6JvkXx5QaW6r+phoClzMVXOVlDS?=
 =?iso-8859-1?Q?wwz+H2NaFey+JH1RdXLgY3kP38FhNJT+e71PPSpUQ1EkCjsujBrHZV76Xn?=
 =?iso-8859-1?Q?tS4x/z/IK1cuashE7YhH4m2GhjZriA6lD9gg4KcLAre8nnbodx34IL3qxj?=
 =?iso-8859-1?Q?kO6i90fCyYji6r/QTG+DRLymMrBaVJIb8QmUoB9SNnnmBWxVnbVOp0Iv6x?=
 =?iso-8859-1?Q?luZgT5tsUtLPUZ14vU6Aflc+qdhJHn87NVn/2bPII68fTc/IHRZkabbbv9?=
 =?iso-8859-1?Q?ZFxT1V/XCIGE88ajoWaLgJqYT88eeVIFxLaJ8O8M1w1TNKV5hSM34C7X68?=
 =?iso-8859-1?Q?Dt5ydZwgo2j358jDaYMPDHp4Dyg72065jrN4XXHEnEKD3/FeAIVQHerPq7?=
 =?iso-8859-1?Q?4b37/W8ZyRz86eGM6YeA+zS5C3sRYOXwlpkRLJbAxH1jxMG63aiZQvBDdW?=
 =?iso-8859-1?Q?Gsz7AwhlStRc7Z/j/XbqYkDRnQtDjiTEQBE+d8otZDtuiIBosHPmLPErL7?=
 =?iso-8859-1?Q?iHq8+TXXkSa/j+ygXdqWXg5L+CXczZJV4KqHU75ADts0iTem7Q0AaPLsE1?=
 =?iso-8859-1?Q?dqgKBdTverK91KYmwGkxfCgSeqVaXRsvEkAm/5FjN6obkgKa/maiJq575V?=
 =?iso-8859-1?Q?NDDfUpil4m8nQ3zo1AEfr56InHZwQqS8D8eA2t4zt/+QMOSgngbPnZJ7JI?=
 =?iso-8859-1?Q?3PFPV7K2mBbJZxyJ+cqzEkulsOrdqKNiI1YN20/xrgRUBkaervqzfmaUqG?=
 =?iso-8859-1?Q?2oHKwF57P2qra2ZNzwLku6hXoREeuBb4O/btiZHhBKl6rXWrdjW/MuA4+j?=
 =?iso-8859-1?Q?hVgYaM4V6MUHcsXCxueH0axw2RHuhuwOvJhATP5bVv+jkB5QJcoAKXL4WP?=
 =?iso-8859-1?Q?iewH6wBmG3u/xMiq0FEh96fTCGG8ep/boYrmuo14sgs79xYwzxfm1Ml8YS?=
 =?iso-8859-1?Q?o+cXnZ50YVNtUHFnWmNho+GXEKCxcSgCiLXX/y6bQlk4QCoM+2dK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d791252-3718-4df8-a3f7-08ded2109ef7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 16:49:56.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /b18QC42KfAGcw/dsxQNVxMEH7AYaASSBu/fqP6mv9x7QS9SuZsdvqh/b983j2/UOPJtTR68IY+Wz1ndAuFgB5wNLJyuaCk2sjkDJw7H1Z/86B0pS5PtLO0iu2C58A9y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12009
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11770-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:noname.nuno@gmail.com,m:andriy.shevchenko@intel.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,m:nonamenuno@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6AD66C0194

On Wed, Jun 24, 2026 at 04:33:53PM +0100, Nuno Sá wrote:
> On Tue, Jun 23, 2026 at 01:27:37PM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 23, 2026 at 11:14:51AM +0100, Nuno Sá wrote:
> > > On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> > > > On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > > > > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > > > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> >
> > ...
> >
> > > > If support 4Byte, it native supportted any N*4Byte.
> > > >
> > > > So needn't bit mask to indicate all support bytes.
> > >
> > > > > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > > > > >
> > > > > > If memory have requirement for 32bytes, typical cache line length for
> > > > > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > > > > >
> > > > > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > > > >
> > > > > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > > > > there... The code seems to use the dma bus width to match against PCM
> > > > > formats supported and filter only the ones we can support (per dma cap).
> > > >
> > > > if cap is one byte, it should support 8, 16, 24, 32, 64
> > > > if cap is two byte, it should support 16, 32, 64
> > > > if cap is 4 byte,  it only support 32 and 64.
> > >
> > > Well, Now I see your point but not exactly. Because we do have
> > >
> > > DMA_SLAVE_BUSWIDTH_3_BYTES
> > >
> > > and it might be used by the pcm_dmaengine code,
> > >
> > > There are also some controllers that set it. But it looks like all that
> > > set it also set 1byte.
> >
> > But this might be not true for all HW in the world. In previous reply I made
> > a comparison with MMIO accesses where not all HW that needs 1-byte read can
> > cope with that. If there is some proof that this is the case when 1-byte
> > DMA bus implies 3-bytes (or other odd number), I would like to see it.
>
> True. I'm also not too keen in making the above assumption and have no
> proof that it will work for the controllers we support.

Okay, I think it is fine by use bitmask. suggest change name to
src_bus_widths,  addr_wdiths is quite confused.

And since not much place use it. suggest change all consumers and cleanup
original u32 src_addr_widths in followup patches.

Frank


>
> - Nuno Sá
>
> >
> > > So your suggestion might still hold and work but I'm not too convinced
> > > that having the array complicates things that bad when compared with the
> > > risk of breaking existing code.
> >
> > > > Needn't mask each bit.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >


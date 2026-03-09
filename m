Return-Path: <dmaengine+bounces-9343-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GEsCzCtrmntHQIAu9opvQ
	(envelope-from <dmaengine+bounces-9343-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:21:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E93237D47
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87040303A85E
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9B938F229;
	Mon,  9 Mar 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oIk+uepH"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF937BE68;
	Mon,  9 Mar 2026 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055118; cv=fail; b=HN36E3oL6sdiQLoOV8ZhWeYikNVnTrfkVQfGYezHSePMUuPjpFWBxDPW7mgUanDRwrCJkCYjUlLOb+5drYP7M/SCqu8Y5g5kH1mdRbqWoX8vMBHLRXXUqjX3tGpG5qLCXbLrz3eZnzFNaAFgINhgUlWbq2xU+z6OY9MsYp+pKMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055118; c=relaxed/simple;
	bh=W1NAUyDUuzFAuCwM9+WRokAhXDin7/wJbT9tP1W3QaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rwJSjsnsltC63QmFUlAWGEMT8OUmzd74TMZhiXcv8W+rum2H+74X/helQXJe2ybRq+pgA8TozX2VL+gRfA8alFMQeo/LrnS4KvrTKJxVnjnZKGeYOdA90v33tKua3wHn5nbHE6FbuBx4Vfk8BIMYq4kJcU5xDcXgiRJu7VL6HxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oIk+uepH; arc=fail smtp.client-ip=40.93.195.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCRRjQgU06gh2tgR4cFx8sujGIsPDIFB1ADtihbKp3ah7ITGaVTVbH4Nj0Vygk9dTT+hhT2SlwpsUr7u+r3k+FiIEndvvybLZissdjWJiYO8blztOnpU5JO7GesRYZdWVCq73YqOJjuRtRaxofvdP+CRhAKAEZ1HbXIy3hiIr8xJ1RGSq+lg8rabYG0E1HpPUeMaoMflOhWCqOcFmN6sqC1uF98ZwcGuImvjqAaFqfp7bldQpoKsxUHQeWuBvviHuKYcn4gaCxJXRosxRLB/QMIfkCbXVvwex094vn/LjamRCYlioVtTQ+vj/IzDL0vPkeb4jtbgot0eyZRC57iXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDLyJiZXPRerYi4d/npLjEc23K5XYCFQl2tiim5YGcU=;
 b=kzKL1oLWSdNzRT36FSmBCBps7fMAjSgCtAWTBoq8iEkZYvgWNj4JzG0viVGmbwHFIGTPbP+ye8sFFsqUDFocWs/W/63/nulp3AGxlgwVCPuAuYjWze7AXygZOvW+6NADQKxYukzcNBLUrpwpQVZlbYLnkfzJFaqwFdwBEoJsCo2so/mBeuNMA/DVuW7orCWENpeVCsQr1WStwZNnZckssYds3fbKzoPLGGIRh5aL/UGEO8KX5/p4PwG2BmNiL/PzV34gacpWb9dtAaXvd/13BvUU/O1kKuhnXWrzP7cwiWTqap4M4LTg/deWe9ads1+6tR3L7VIYnJjGrGvYmQZ8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDLyJiZXPRerYi4d/npLjEc23K5XYCFQl2tiim5YGcU=;
 b=oIk+uepH70DG6bDWXNeVjkI3pl/4Gl28EkZjsY/PuZ1JwFT/eY5/nm9Kyr3eGPVaiYJfmcOkDrW9QEdONXFdkRImSrTLJUADWSH6TX0872Jp854UWHBOvw7edt23NbyuJP1jbpewt+rnigbAw6s2sbSdaKNxclz+VcLfK+eoDvk=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 11:18:33 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 11:18:33 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcrV+81oF37YcXsEuF2ca3rlBfa7WiAmsAgAPv1kA=
Date: Mon, 9 Mar 2026 11:18:33 +0000
Message-ID:
 <SA1PR12MB8120969E61FCC5C46F1C1B739579A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260306115228.3446528-1-devendra.verma@amd.com>
 <20260306115228.3446528-3-devendra.verma@amd.com>
 <aatEUuynXVVYEhWy@lizhi-Precision-Tower-5810>
In-Reply-To: <aatEUuynXVVYEhWy@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-09T09:24:16.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|PH0PR12MB8798:EE_
x-ms-office365-filtering-correlation-id: aa4377e4-2d1b-4640-d425-08de7dcd9997
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 geSWqcRg9x75CPLsAwJFiROU73FTJXe206mAy3jD9ZD1BkeO4rUzYW1ZDOssc5H0QHaKheacFj+YE5xa/2ID40VAt3YKvTnysX7KPDjgrdbOdlMJIztcsz/L8mrVhLMitsu+0kjTwCOXSyYN9jDZp46GvWLlc2+8KS8UTKcqHzLdNzHjZowhaQpCrbf3rbVkHTQReUcI5F5maKr/2jF+sidgivBtjOT1gS/hQhvzrohfdbK/MiD6BQVxOOwk9wkaxiKNDOB+E0Pt0rx4NejsTcy7nmhePFLbaveyKBrYGmmEw25+BmvP1Rl0BBvtguyorGN0Lc6Xs6F19DqwZHOZFp0D5+El2HawKbYkEn2pDodnoB78bDMapZ5p5Cjf7SGGDqPgqcki2OAM1c8Vw4j/qFpP4gVBqRaHqEJYLdJ+G3psF4K94DsAjGXweJjebHQ8TCysGsCzpWA6FqGMmI3Y1i45LmgPjE0rbbB5qPusf2f98JX+mUuyN5VVQwTb+ksRSloZucoCp9T9MXuROlipcgd1yvriScjataZRZCvqd1TldQB44zag2oH7BRDvf/KwioNvf6DP7e6izn8e7kf9+ehPzShtjqa+Sm+QDJQgnTM0usDS05+3eVFF+Oigy5obG4QccmcqDxj6Ttwuq2ldt42eSaXuaJlSiG+chwz89b4XYzEc1BElMeWaZF4SYlPUrzL5A7rR1rWJxq3K2y6n7cNvDWxuU6ExKvzFV+v/VeWgJby75EaVHBbgF9zQ1t+rekbD6cKktwxl54mTRyqnhxKO3SsomnfHiY5KJmmZPXM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fIWcN8mFyROpWMeS6DJ73QmcxiYunJbWg3qQikjKSEUgEvPmNzqv9uE99W8U?=
 =?us-ascii?Q?uakhpWVI4ErIhw6aIJPt1tnw8f+A0gf268GIpYU7klnlna4/MJYrNDH3HlWr?=
 =?us-ascii?Q?tuhg/OxHWN99Chpx7ATOiD9f/5PsTYhePaP5wY5vprIiHpuHCRtkVBuhSezu?=
 =?us-ascii?Q?cYtlFwc9Ur2CNspVnDXi0EL/Rak/bfKrr9Y8PlGMJaDfNN+lia7WUER02H8k?=
 =?us-ascii?Q?zMYQxRlGm0Aw0u60dltKSM9Pcie3Ql4PJftn9VapiVBeSbkKECwz8gb3zyGF?=
 =?us-ascii?Q?5HJo0ePqFmL/heUjS1pJUG0tutnZggoXWEKbINr+e2xj2ifNOpFSjqUdO8zv?=
 =?us-ascii?Q?OMEQXzltqopbJCkSAFPV5cDvUSnLgqZ8eLeEMfLQXm8565Fe/SW20i7x+lL7?=
 =?us-ascii?Q?9ULILb/Db0twPgxprUNRbiQDnebmATCRsEZRBgibgdwGVOHcIsQOO0bbNJfV?=
 =?us-ascii?Q?7LvQiffDr3GCWGEuTqfPrF+7+eigpddUyIybg8hxCjt11uXYHhBsG+JAvdHn?=
 =?us-ascii?Q?+E1dnIoNYZAAhG/y8Bb8Bigkv89eN5G59BIM7RPIyNEqQo/VIDzQEAJzS+fR?=
 =?us-ascii?Q?1amvPvFlD49/JpkQubCdXAl536GAjwVzc/pTSmdaDvLe877nCA/FL5bDB67K?=
 =?us-ascii?Q?nZo34NCHp+NmG3Z7IBZIULs0HBJG3PS6E/E+bot5Ms9ohNTadV+vAYLAWQKB?=
 =?us-ascii?Q?Ne969GlVfkQKg3pOfX5zs76X2vQJBQZdbKVrA9KUaPU1PDYjVeeOFjBJ/vYk?=
 =?us-ascii?Q?5F0QY9nYvItjTvE2qrp2wZgA0N7AUT25fevCsa8gZq4slaX2XHYzc14Aeq3i?=
 =?us-ascii?Q?+k4vezskqzY+sLN2Ffsxo8rJjgR8QKBocogfd3iRkRzA8DpDAHHOYMh1zU4p?=
 =?us-ascii?Q?nl91y+BHbXOIJBiWn9j8iPoPmkekoi24wEFY8md9PJVumQS5S7NA9+DRrpZR?=
 =?us-ascii?Q?T1PKHWJraakvJ7iBlvsEWV4pXl/OloLiUWXyXYTODXcfM5PwqFHjrezZwciG?=
 =?us-ascii?Q?XAKn8SGzi/u1IsmZmmF4BTM2f5q+fw1jJ5ODUsp4aCSyDCOHYf/kyxi3vr+p?=
 =?us-ascii?Q?JzaACjMeiegulgiQiJtTmWKFL5Uz+IlyUzGCXDmu7WCSPymj1YCqWl+ihK8i?=
 =?us-ascii?Q?ZBxsBY11QnsAXpjMG39QTASzuq09sSst+vJrGG9p+NgQF0rMCZxPXDlA6i2H?=
 =?us-ascii?Q?WA/tyhXVaQbcxRLcfXPlqYWlpd/UGXPGefBTWCBojrf6CrfaiYc+UIh/fJD2?=
 =?us-ascii?Q?/vA3OcKt9e2seXny246NlXaje0IPduUjnxezeXwytvVh7TPJOFlxCaMtfh1G?=
 =?us-ascii?Q?OtCM/1YgXRP0cfTYAzO+HoEUmY4v7ezMpS3m495piWaR0D/bYOFewKNUVtJG?=
 =?us-ascii?Q?Ff/foWdmlxHAuDE2d1B47kQciZImQ8awDdNLdu8WJJ0HLD4Zdc6FSykjl3AE?=
 =?us-ascii?Q?8ncp2hSEUI92QvG1qhl9arae41l6125FXApbeWScuLyyFr5i5XozNVEJNZD5?=
 =?us-ascii?Q?P2UJ1dNe4/h/C8IIeiVU3ZOvgBgVWe0fseDrQGDEsZWToHkPvCwXt6KMad7m?=
 =?us-ascii?Q?7ELaUmExsVfJko2QqruEuJ6G7euYTXUjd0NRNemLW36ymWpVzmA7z/OhSV4O?=
 =?us-ascii?Q?KTMIqVmtAYoHKn0zrmUc04Hrp7DZWEY5otveJiTqkDOB3vqVpzNDP+6jrsQF?=
 =?us-ascii?Q?xOQM+WrU7mvV+iGPfgLFZEd+79BoY2e4luqpfZz6c8WXuBsj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4377e4-2d1b-4640-d425-08de7dcd9997
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 11:18:33.1399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQFzaXlIXphj4R7suHwmV7S+ccqI0kfauV+KznkwmXUVVa6pbdMDniG8VL/aTShFMwB1yWIT6SrTMdWW4+KxvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
X-Rspamd-Queue-Id: B5E93237D47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9343-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,SA1PR12MB8120.namprd12.prod.outlook.com:mid,nxp.com:email]
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Saturday, March 7, 2026 2:47 AM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Mar 06, 2026 at 05:22:28PM +0530, Devendra K Verma wrote:
> ...
> > +             /*
> > +              * When there is no valid LLP base address available then=
 the
> > +              * default DMA ops will use the non-LL mode.
> > +              *
> > +              * Cases where LL mode is enabled and client wants to use=
 the
> > +              * non-LL mode then also client can do so via providing t=
he
> > +              * peripheral_config param.
> > +              */
> > +             cfg_non_ll =3D chan->dw->chip->cfg_non_ll;
> > +             if (config->peripheral_config) {
> > +                     non_ll =3D *(int *)config->peripheral_config;
> > +
> > +                     if (cfg_non_ll && !non_ll) {
> > +                             dev_err(dchan->device->dev, "invalid conf=
iguration\n");
> > +                             return -EINVAL;
> > +                     }
> > +             }
> > +
> > +             if (cfg_non_ll || (!cfg_non_ll && non_ll))
> > +                     chan->non_ll =3D true;
>
> this logic have a little bit complex
>
> if (cfg_non_ll)
>         chan->non_ll =3D true;
> else
>         chan->non_ll =3D non_ll;
>

Thank you for your suggestion.
I think it is individual preference. I am not sure what seem to be complex =
in the
logic floated for review as all the boolean operations are easy to comprehe=
nd
in a single statement.
I am sure there are multiple ways to write the same logic.
To me, the logic you suggested looks bigger with the same outcome delivered=
.
If after distinction in variable names and simple boolean ops still cause c=
onfusion
then I am not sure till what point it can be simplified.
If fewer lines of code can deliver the same result, then it should be ok to=
 keep it.
I would request to keep the change of the floated review.
Thanks!

>
> > +     } else if (config->peripheral_config) {
> > +             dev_err(dchan->device->dev,
> > +                     "peripheral config param applicable only for HDMA=
\n");
> > +             return -EINVAL;
> > +     }
> >
> ...
> >
> >  struct dw_edma_irq {
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index b8208186a250..f538d728609f 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -295,6 +295,15 @@ static void
> dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> >       pdata->devmem_phys_off =3D off;
> >  }
> >
> > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > +                              struct dw_edma_pcie_data *pdata,
> > +                              enum pci_barno bar) {
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > +             return pdata->devmem_phys_off;
> > +     return pci_bus_address(pdev, bar); }
> > +
>
> Reduce each patches's changes, make each patch is straightforward
>
> Create Prepare patch firstly, change pci_bus_address() to
> dw_edma_get_phys_addr()
>
> just
>
> dw_edma_get_phys_addr() {
> {
>         return return pci_bus_address(pdev, bar); }
>
> So this patch just add
> two lines here
>
> if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
>         return pdata->devmem_phys_off;
>
>
> others look good.
>
> Frank
>

Regarding this we already had discussion and it was concluded to let this p=
iece of code
to be as is. Please check the discussion at the following link:
https://lore.kernel.org/all/aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-5810/

> >


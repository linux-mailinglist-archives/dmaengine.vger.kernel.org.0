Return-Path: <dmaengine+bounces-10368-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHdyKz84A2qK1wEAu9opvQ
	(envelope-from <dmaengine+bounces-10368-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:25:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B6452261E
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09A73134B03
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CBB3AEB43;
	Tue, 12 May 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcDVyezd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD339DBD9
	for <dmaengine@vger.kernel.org>; Tue, 12 May 2026 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595536; cv=fail; b=OKdDb07OqRPY2s8YVDXGtRq32cCDAUuxmtC2F/PU/ifHK+t/nlj3evuCLWeT+f+DkCFTuU5zemyxGlsNkAyOxyNx63GpWrWgVTberTQPYstiJYSXIPNBjgH4tUaRGEKfMr2RQNtsNbHfLJHVyWQ63KTF5z5WbFNoIZoB6+IQqwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595536; c=relaxed/simple;
	bh=4xlRMdoVCoSoks29nHwthqBJRXmFEBNHrh0zdZIQfB8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=r6lT2CEwOmrmxP6zMOmLWSOCHbEFgIg8LllLC7mYXzJ1LcWcgJBCeS1Lvs8T05r4pR3ZLnJPTt2gxxx/TCmohKlLqHGNYwCcEQoogIXkI99M5CVdoExdsTYHV4OOJ/M8JEA0yNecKBoEF0xPargVLFpGeKcJx0eau7fzOraaO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcDVyezd; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778595531; x=1810131531;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4xlRMdoVCoSoks29nHwthqBJRXmFEBNHrh0zdZIQfB8=;
  b=LcDVyezdu9LjNTFkqCwSXINf9wlZ9IYrepByilkeaqLZPxlSheqTaAKH
   WDgnvt0y9eSN8BC8gCCYQjbtHYoIe58ypRUiJ4SWB5DJgh1etGqPcn4kC
   8gyy/aztXRFTYMMPj3b9KBBEZ8GwyHHiA1nyp9ZOR4PjFhxIzNZpx1eB2
   bPpS4TGqtkQbybhwrgbgYVKNgNI/MM86n26LIU213RgZvzSD92GvA+BDW
   IwYiKMoukui0XkwfiISl8HjGsPYi2fj5S3QfYe0A0eS/8Ux+4J/nYB6jG
   LTcgeKBSbVndelSULdACertYZZ+10TFJPiTkSOvJnJcT5DFuGTwBv8NpD
   A==;
X-CSE-ConnectionGUID: 6TmYXOkmSPeJ1SxpHcCdLQ==
X-CSE-MsgGUID: Uhy2/ifPQzq71c0uwu5ruQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90085212"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="90085212"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:18:50 -0700
X-CSE-ConnectionGUID: tfF2quOHRY+UsjJ+kiwPcQ==
X-CSE-MsgGUID: EvNsQmUJQEWw+KCjmnnNmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="236797019"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:18:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 07:18:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 07:18:48 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 07:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiLQ47rZuaq9v4gyeBVFl5yCv2C2/dRPlI5GI4FkmIHVscWBEZENOEFxRoqDs6e68akHnNJliKskIoWSu/dcMcAphHpUsmVaFBQr/mFgX8Y3bv2a4x7HyDRdIs3nb3AFOypfHSUEJgcYwgApIU7Sqjp6ogViW4zn0xem2MUBRee7X8hwJR8qhSZmdgydz374eYQJ2n7WJuzPejJ8LUzlFfL6tbbyHF82VDu4eLSzBvPiQCi6tZnIGMrchA1qwDjE2lQwkS3jeFfVadsoS7boOTwPUtmXMyBI7H4wtZSUa4B92djFRZ2VJked5RhFHTQLWt7yZVeTw5sC6u83UE2r1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vai3HM5PXJ9GgZTlsXbvoV/tZFtPAD8fme/hKO5rlHE=;
 b=hP2E2/P7snDDBQLvgtfWVPGA1GY38DKpnuBHfPVr5f0h+fe5D+dUFrPvdxeyn4yM3CtH94ugAAd3chysBW5FlLlxSb6rAr085YlCpZml/nGV+zVGzBMKWT1hHc0xOR272mF0KblEm24sVaehtv9YfQXd38hHhDBd59HVxnRBRWZIQrBRNU3+qMjYv+nhuAnUs+Kex1SIlqE18zXixzFdvQWFCnMG4FJ3Lc4C8kOZa6jzCrpxPna1klTXYBB7ZEedvmwXvK/VD8BP3qwIA922pr2z/W5QjTmcQEzw4m73kvWhrqwNpkfryL3+2NMGx32FGjklu/K79q28AtD6Ob5GdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SJ2PR11MB7645.namprd11.prod.outlook.com (2603:10b6:a03:4c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 12 May
 2026 14:18:43 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9891.019; Tue, 12 May 2026
 14:18:43 +0000
Date: Tue, 12 May 2026 22:18:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [dmaengine]  2a93f5747d:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <202605122202.4673084b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SJ2PR11MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a610f78-b384-4539-8acd-08deb0315edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: ynXm0LmWZdiMyRI2duV4++SLgUkEE87zZGW+0Y7k/IFkNUy69uM9kmiOD+AAooYYFG1Dumaq6vOHB6qLCD2/MXbwFNJqob6NFoUmItOg7NRHgkeN+bnT0Pf0CGtiUKq0hdA/md/QlnmbBhS2T0CDDs+D7qT9yODQFkvZAtouDfs8FwYfZ6us0eS9JA+SMVm7DpJ+1nIiYjLApNIrTdZKczdEPbuNH2H/EF7kSb5cUTJB/cUNidxV3pbAte3kiJxOoD53Ty0mePxyR4bo6ZXFdCol/aieZEvVn3yvXRcb77idLY4A/ivAGpPPfPy1Q68n5IlzGYunvhbYEN/uV3S175GYluKkVHvmhSweABsBpDTqa6Xj8fnnM7IynU5kT58rmEBb/+ncqEQXEeRIMhxOrwpUqj5Ks9J+BGeoNEoi2D3H4/AEv/w1rkidTxVcK9GXq/egNhtn7w7fiVH4jufg4+yGlA0WKBdhlyEozf657s4SbnKEroqvzLrAKvVueM9+gvs9Q8nTCNpzpME3TuXDxjI7WA0doVd9qhNw6OTAxHd/VYLmLorxHPN2dfC8rq1FdphBWI7IdRcL8q6CXa8RnDfDEQ/zLEjHmDuP5nHh9gOdXj2JgWqhmNjVLWNY3B1dYPOL7JQEGa1CN0Rg0d3c9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72GtBCSKv3x8ivkY9ySzFV6DkCisB3kTsp3fMXxZ4uFJ0TB3WiSqusKNpEk+?=
 =?us-ascii?Q?vccAYNjRVsXKxPvVGaJhn3AOyKX++pRUBLG9rHLHDVgCAdsElHVlt5kH5Tgn?=
 =?us-ascii?Q?d7mO4wbwQ+fPFmEnG2pW6WRgupkZsTJYbNa4wPzKGHOEMZQmSytWmUzHk45c?=
 =?us-ascii?Q?XUG+9cBDUeI99k+TYWGHUQWzIMItXKUk7Cp0eMcAPoGl7GxIJh2WPgFeZpxg?=
 =?us-ascii?Q?7pVlXiYdp3Ye8ZaUIEB/pSCkWL9ZSoIp0VJCyIJcYiya9Tjg3VNODZhk70YP?=
 =?us-ascii?Q?9mK9KgmJujjYQh0NBFE5VUYfAxkXaXGLlUlWl3Y/8EiHEXmzhYiu7QDys6RD?=
 =?us-ascii?Q?4gPzE6YAFyNguW9Q8RYCWdQdw6+C1R25bAdPk/CObd7n655DfmG8w1asopqV?=
 =?us-ascii?Q?f3V+V8Kcp+IxAvc6v5rnLDvL4JCDC7A9tzdrD4sD2IZB9DdoP3Ehv4EinVii?=
 =?us-ascii?Q?fKyp1XV3PbfS2mA9jLCUtDgcgWlW9qigwo0b1JoI9zO6aJhSQMr4uwBhCl9s?=
 =?us-ascii?Q?YZM3mUsfW4VDxVe8znB89MCNuyCNoHmkcOiOeI2MqyxEm73C9ADSQaZlIH31?=
 =?us-ascii?Q?IXc5h8eyneEAOMMfYxqCjP5CtwsNYnvqYJyn+U4yUuQfXM7atiQb9Tso/8eY?=
 =?us-ascii?Q?X/RavgHWVheNtGfgdCDT3lpUgDeJdU2VzrJ7MKbANY9+6OPazdFbpExqBPKS?=
 =?us-ascii?Q?JIG0G07xNMSQVAaDDXhKpq0nie0l5Lj24zY8xskS2JWIo4i3NYqAqBRigsr5?=
 =?us-ascii?Q?JdJAgl5OH5YyXteJjVQOr0iOPp5vJ/RY721CpeSYT6Cziy/b0As9BQil/zkC?=
 =?us-ascii?Q?GoVk8rOnljgY1CarK3azyboiFhE382hGTJ0Pz+fZSNmG9Z5AhB9L9qUNXqDt?=
 =?us-ascii?Q?UmYbiqqdZoib24C/FqeIlH08WyEvsvvlnm1nNimU9IF8KIE94jIKPBqUqgqa?=
 =?us-ascii?Q?hMGwenZJPrF/+5+7QQFMoNl1hd6Q3Pz9E1EwtaSx9F74XqlxeUO2TMO3Ro0P?=
 =?us-ascii?Q?5c1g//yfBXjlyo3Qkg1Uj2kOGDMGSu7PNzLCPi9s84o/1u58qndyn9w2fQJ9?=
 =?us-ascii?Q?4gsy9YoKJsBemUCLXZ/K7XDp8ntKGcNAtvdZRAZaEHJicT2mv6VgiepHUTAi?=
 =?us-ascii?Q?NcR1nDhDk+BZvhf1AYXuZmRHQ1+3AAssUOQr4jvozEJlhGJ0HBE4oS/N4ma6?=
 =?us-ascii?Q?F2XnFF7wGPeQtT4vE2UhicIs6Bj1owEyaZ0MSrV5pk7zX6fb1BqQQ+xkM8O5?=
 =?us-ascii?Q?dfcEMW0LAQmh/6UqNKqfSYpvbBPRYFwBBpqg2nW+pU8q67DvnAIGVsaoSGrF?=
 =?us-ascii?Q?mZaTIwPDyl4Qb9GsNq60U/FTIrr2w51BoPXI+tbLErcuLIyorVblFj+AYAgC?=
 =?us-ascii?Q?0B26nSc+6no23CACK8U+Q0bmPK8c/tCsPgoW9xBfL835ZdqJhytpUJFD/mUO?=
 =?us-ascii?Q?EhrEvoep2hUnMSmrLCixq5JScwyzTCWtbVYVWqnf6aHCMneqmiqh4HlyCZY2?=
 =?us-ascii?Q?uW7WE8+Zf4h9xkqlWC9eZsRvDmwUbO22zKMD+11j419Rm4IXG32Bu+SiQ5EE?=
 =?us-ascii?Q?2Uyzz0KRDOjRADQxCouNaijGZy9tHoOFBKyOZ1+xMP3kIJNjj6Ah/mjvlypc?=
 =?us-ascii?Q?STCGx89JFP130BA7rC05LG1tkk8YPOPfKD/0/Iu59skUJZnPFLdUcLQJZdkc?=
 =?us-ascii?Q?Va4oe9n4ZgQ1g1mrb3OSfJKxmlmA+7Dj5ttZg9grJ9H0nJZ2jA6NnCLaNExn?=
 =?us-ascii?Q?3Am/LJdeQA=3D=3D?=
X-Exchange-RoutingPolicyChecked: CCaPHJPRZp8xN7+30ssogCQIY9XhOB+D/TylFiSbWuFi3VCyCX4JGLjCE7d6kuMlTCW9YSPfv4J8EHRWDLEr7+IFyKd0kP2P+chnErxfJuT0k2eaShCglh1aBXHq35HakS2iPDAH5QrC6nra8dfj2R+ihecIdSXt9ktxb63a6dWI2TkVx9Xs5Kca+H10K5kgSf6WxO9pE0zKhoFNbFJWp5Y6WQ0GPZYlDUteFd/mpI4gxAmkDANmn+iVudpvi54/cEsj/0ZAQ38pRuT4KFZEgnoA0v1sxMJxg+VGlssGoeIRILnMKe69KwZi+BGvtSwD0LGahGYtktDu+25JaqBTFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a610f78-b384-4539-8acd-08deb0315edb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:18:42.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CEhU2MTuUww4TUZ6EDcdQvjYb3JolYVdSQPZQnlB5wZbGUIXbm9myZKHoaQWvjYdnf7dets6wSbiaiuDV5u9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7645
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D8B6452261E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10368-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:

commit: 2a93f5747d0eef89a3158c91d185d37d0bca2491 ("dmaengine: idxd: Flush all pending descriptors")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 17c7841d09ee7d33557fd075562d9289b6018c90]

in testcase: lkvs
version: lkvs-x86_64-61a640e-1_20260309
with following parameters:

	test: dma


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 512 threads 4 sockets Intel(R) Xeon(R) 6768P  CPU @ 2.4GHz (Granite Rapids) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605122202.4673084b-lkp@intel.com



kern  :err   : [ 1003.647599] [   T3317] INFO: task modprobe:14010 blocked for more than 491 seconds.
kern  :err   : [ 1003.656066] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 1003.663506] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 1003.673586] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 1003.686935] [   T3317] Call Trace:
kern  :info  : [ 1003.691033] [   T3317]  <TASK>
kern  :info  : [ 1003.694276] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 1003.699422] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 1003.703945] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 1003.709568] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 1003.714555] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 1003.720795] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 1003.725319] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 1003.731446] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 1003.737995] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 1003.745025] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 1003.749829] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 1003.756670] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 1003.762738] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 1003.769582] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 1003.774793] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 1003.780922] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 1003.786116] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 1003.791958] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 1003.798024] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 1003.805442] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 1003.812251] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 1003.816937] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 1003.822741] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 1003.828113] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 1003.834033] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 1003.840202] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 1003.847081] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 1003.852978] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 1003.859090] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 1003.865996] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 1003.871986] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 1003.878731] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 1003.884249] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 1003.891836] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 1003.897949] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 1003.903468] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 1003.910218] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 1003.916900] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 1003.921951] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 1003.927506] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 1003.934084] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 1003.939945] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 1003.945882] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 1003.952332] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 1003.958514] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1003.964061] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 1003.969770] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1003.975925] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1003.981750] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 1003.987051] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1003.993070] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 1003.999253] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 1004.006325] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 1004.012689] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 1004.018564] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1004.023959] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 1004.030718] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 1004.036015] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 1004.042867] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 1004.047875] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 1004.058115] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 1004.067242] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 1004.078425] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 1004.087586] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 1004.096974] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 1004.106206] [   T3317]  </TASK>
kern  :err   : [ 1495.167286] [   T3317] INFO: task modprobe:14010 blocked for more than 983 seconds.
kern  :err   : [ 1495.176008] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 1495.183559] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 1495.193793] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 1495.207873] [   T3317] Call Trace:
kern  :info  : [ 1495.211671] [   T3317]  <TASK>
kern  :info  : [ 1495.215057] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 1495.221126] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 1495.225811] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 1495.233418] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 1495.238578] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 1495.245326] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 1495.250007] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 1495.256255] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 1495.262968] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 1495.270602] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 1495.275561] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 1495.282524] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 1495.288741] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 1495.296134] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 1495.301464] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 1495.307603] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 1495.312932] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 1495.319289] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 1495.324674] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 1495.330544] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 1495.336499] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 1495.341392] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 1495.347230] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 1495.353907] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 1495.359808] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 1495.365950] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 1495.372854] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 1495.378540] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 1495.384931] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 1495.391113] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 1495.397925] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 1495.404492] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 1495.410255] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 1495.415552] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 1495.422069] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 1495.427628] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 1495.434865] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 1495.441582] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 1495.447152] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 1495.452705] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 1495.459267] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 1495.464499] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 1495.470381] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 1495.476332] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 1495.482514] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1495.488608] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 1495.494619] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1495.500017] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1495.506036] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 1495.511626] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1495.517016] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 1495.523913] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 1495.529804] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 1495.535823] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 1495.541421] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1495.547415] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 1495.553688] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 1495.558989] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 1495.566323] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 1495.573404] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 1495.583006] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 1495.592795] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 1495.601939] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 1495.612330] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 1495.622313] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 1495.631905] [   T3317]  </TASK>
kern  :err   : [ 1986.687102] [   T3317] INFO: task modprobe:14010 blocked for more than 1474 seconds.
kern  :err   : [ 1986.695933] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 1986.703497] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 1986.713754] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 1986.727842] [   T3317] Call Trace:
kern  :info  : [ 1986.731648] [   T3317]  <TASK>
kern  :info  : [ 1986.735396] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 1986.740466] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 1986.745204] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 1986.750796] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 1986.755929] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 1986.762410] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 1986.767077] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 1986.773230] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 1986.779945] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 1986.786840] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 1986.792144] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 1986.798860] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 1986.805176] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 1986.811895] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 1986.817664] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 1986.823689] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 1986.829139] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 1986.834862] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 1986.840811] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 1986.846184] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 1986.852567] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 1986.860409] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 1986.866936] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 1986.872168] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 1986.878226] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 1986.883831] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 1986.891134] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 1986.896827] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 1986.903114] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 1986.909445] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 1986.915435] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 1986.922174] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 1986.927685] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 1986.933472] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 1986.939365] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 1986.945111] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 1986.951201] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 1986.958285] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 1986.962800] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 1986.968833] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 1986.974877] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 1986.980581] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 1986.986516] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 1986.992430] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 1986.998615] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1987.004633] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 1987.010334] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1987.015721] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1987.021235] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 1987.026547] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1987.032575] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 1987.038763] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 1987.044974] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 1987.050867] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 1987.056879] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 1987.064379] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 1987.070865] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 1987.076167] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 1987.082968] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 1987.087966] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 1987.098375] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 1987.107491] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 1987.116636] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 1987.125772] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 1987.135341] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 1987.144510] [   T3317]  </TASK>
kern  :err   : [ 2478.206898] [   T3317] INFO: task modprobe:14010 blocked for more than 1966 seconds.
kern  :err   : [ 2478.215734] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 2478.224125] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 2478.234180] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 2478.248546] [   T3317] Call Trace:
kern  :info  : [ 2478.252513] [   T3317]  <TASK>
kern  :info  : [ 2478.256133] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 2478.261445] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 2478.266414] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 2478.271972] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 2478.277210] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 2478.283629] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 2478.291353] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 2478.297417] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 2478.305035] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 2478.311950] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 2478.316994] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 2478.323714] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 2478.330318] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 2478.337028] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 2478.342453] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 2478.348468] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 2478.354218] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 2478.359937] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 2478.365361] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 2478.370678] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 2478.377026] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 2478.381662] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 2478.387616] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 2478.392825] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 2478.399135] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 2478.404733] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 2478.411748] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 2478.417442] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 2478.424144] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 2478.430322] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 2478.436447] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 2478.443028] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 2478.449135] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 2478.454445] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 2478.460936] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 2478.466426] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 2478.473099] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 2478.479769] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 2478.484896] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 2478.490400] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 2478.497073] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 2478.502626] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 2478.508527] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 2478.515265] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 2478.521446] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2478.526955] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 2478.532642] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2478.538472] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2478.543862] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 2478.549294] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2478.554684] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 2478.561727] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 2478.567625] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 2478.573733] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 2478.579321] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2478.584699] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 2478.591094] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 2478.596395] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 2478.603274] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 2478.608766] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 2478.618576] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 2478.627689] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 2478.637219] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 2478.648354] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 2478.657501] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 2478.666906] [   T3317]  </TASK>
kern  :err   : [ 2969.727015] [   T3317] INFO: task modprobe:14010 blocked for more than 2457 seconds.
kern  :err   : [ 2969.735853] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 2969.743414] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 2969.755415] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 2969.769063] [   T3317] Call Trace:
kern  :info  : [ 2969.773335] [   T3317]  <TASK>
kern  :info  : [ 2969.776736] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 2969.781940] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 2969.786645] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 2969.792682] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 2969.797852] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 2969.804098] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 2969.808772] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 2969.815334] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 2969.822062] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 2969.829100] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 2969.834069] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 2969.841352] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 2969.847586] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 2969.854776] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 2969.860119] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 2969.866702] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 2969.872031] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 2969.877862] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 2969.885668] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 2969.891044] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 2969.896959] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 2969.902581] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 2969.908409] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 2969.913797] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 2969.919713] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 2969.926012] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 2969.932875] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 2969.938693] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 2969.944780] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 2969.951587] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 2969.957580] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 2969.964282] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 2969.969785] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 2969.975530] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 2969.981428] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 2969.987032] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 2969.993131] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 2970.002061] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 2970.006582] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 2970.012256] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 2970.019177] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 2970.024383] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 2970.030418] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 2970.036816] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 2970.043005] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2970.048548] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 2970.057434] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2970.062837] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2970.068391] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 2970.073691] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2970.079720] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 2970.085904] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 2970.091946] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 2970.097837] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 2970.104078] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 2970.109471] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 2970.115491] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 2970.120787] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 2970.128059] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 2970.133070] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 2970.142818] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 2970.152122] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 2970.162115] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 2970.171746] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 2970.180902] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 2970.190724] [   T3317]  </TASK>
kern  :err   : [ 3461.246645] [   T3317] INFO: task modprobe:14010 blocked for more than 2949 seconds.
kern  :err   : [ 3461.255569] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 3461.263723] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 3461.273706] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 3461.287407] [   T3317] Call Trace:
kern  :info  : [ 3461.291749] [   T3317]  <TASK>
kern  :info  : [ 3461.295287] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 3461.300365] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 3461.305039] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 3461.310594] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 3461.316291] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 3461.322439] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 3461.328574] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 3461.334626] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 3461.341513] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 3461.348426] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 3461.353872] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 3461.360594] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 3461.366893] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 3461.373606] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 3461.379706] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 3461.385732] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 3461.391135] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 3461.396867] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 3461.402833] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 3461.408375] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 3461.414289] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 3461.418906] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 3461.425092] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 3461.430311] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 3461.436454] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 3461.442058] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 3461.449494] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 3461.455682] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 3461.461775] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 3461.468608] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 3461.474595] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 3461.481299] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 3461.486804] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 3461.492623] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 3461.498539] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 3461.504213] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 3461.510299] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 3461.519279] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 3461.523794] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 3461.529482] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 3461.535472] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 3461.541678] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 3461.547578] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 3461.553674] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 3461.559914] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3461.565775] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 3461.571499] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3461.577039] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3461.582439] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 3461.588090] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3461.593535] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 3461.600310] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 3461.607328] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 3461.613681] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 3461.619285] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3461.624914] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 3461.630810] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 3461.636390] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 3461.643100] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 3461.648379] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 3461.658019] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 3461.667793] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 3461.676947] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 3461.686171] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 3461.695923] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 3461.705097] [   T3317]  </TASK>
kern  :err   : [ 3952.766598] [   T3317] INFO: task modprobe:14010 blocked for more than 3440 seconds.
kern  :err   : [ 3952.775513] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 3952.783571] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 3952.793566] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 3952.809282] [   T3317] Call Trace:
kern  :info  : [ 3952.813085] [   T3317]  <TASK>
kern  :info  : [ 3952.816865] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 3952.821935] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 3952.826777] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 3952.832331] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 3952.837930] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 3952.844072] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 3952.848859] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 3952.854906] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 3952.862036] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 3952.868943] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 3952.874025] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 3952.880733] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 3952.887381] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 3952.894085] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 3952.899569] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 3952.905586] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 3952.911659] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 3952.917372] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 3952.922870] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 3952.928706] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 3952.934619] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 3952.939429] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 3952.945820] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 3952.951032] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 3952.957136] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 3952.962724] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 3952.970056] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 3952.975740] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 3952.982093] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 3952.988293] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 3952.994260] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 3953.001625] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 3953.007397] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 3953.012709] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 3953.019409] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 3953.024901] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 3953.031670] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 3953.038395] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 3953.043223] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 3953.048774] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 3953.055475] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 3953.060693] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 3953.066824] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 3953.072608] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 3953.079246] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3953.084637] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 3953.090595] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3953.095992] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3953.102841] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 3953.109281] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3953.114674] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 3953.121607] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 3953.127492] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 3953.133588] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 3953.139897] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 3953.145295] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 3953.151444] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 3953.156734] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 3953.164373] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 3953.169365] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 3953.179151] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 3953.189071] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 3953.198563] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 3953.207720] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 3953.217407] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 3953.226567] [   T3317]  </TASK>
kern  :err   : [ 4444.286666] [   T3317] INFO: task modprobe:14010 blocked for more than 3932 seconds.
kern  :err   : [ 4444.295492] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 4444.303054] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 4444.313593] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 4444.327634] [   T3317] Call Trace:
kern  :info  : [ 4444.331435] [   T3317]  <TASK>
kern  :info  : [ 4444.335488] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 4444.340576] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 4444.345394] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 4444.350956] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 4444.356794] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 4444.362942] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 4444.367759] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 4444.373816] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 4444.381240] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 4444.388661] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 4444.393630] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 4444.401176] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 4444.407410] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 4444.414249] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 4444.419593] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 4444.426278] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 4444.431624] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 4444.437527] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 4444.442852] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 4444.448790] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 4444.454707] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 4444.459485] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 4444.465278] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 4444.471117] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 4444.477023] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 4444.482794] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 4444.489661] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 4444.495831] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 4444.501923] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 4444.508334] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 4444.514329] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 4444.521379] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 4444.526878] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 4444.532308] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 4444.540752] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 4444.546315] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 4444.553034] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 4444.559761] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 4444.564858] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 4444.570390] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 4444.576514] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 4444.581725] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 4444.588075] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 4444.593862] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 4444.600247] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4444.605659] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 4444.611981] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4444.617383] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4444.622810] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 4444.628390] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4444.633829] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 4444.640500] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 4444.646425] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 4444.652482] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 4444.658071] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4444.663947] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 4444.669835] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 4444.675343] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 4444.682008] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 4444.687483] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 4444.697087] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 4444.706497] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 4444.715603] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 4444.725037] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 4444.734360] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 4444.743528] [   T3317]  </TASK>
kern  :err   : [ 4935.806504] [   T3317] INFO: task modprobe:14010 blocked for more than 4423 seconds.
kern  :err   : [ 4935.815428] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 4935.823254] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 4935.833693] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 4935.847677] [   T3317] Call Trace:
kern  :info  : [ 4935.851466] [   T3317]  <TASK>
kern  :info  : [ 4935.855316] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 4935.860376] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 4935.865187] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 4935.870746] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 4935.876601] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 4935.882747] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 4935.887517] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 4935.893571] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 4935.900841] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 4935.907747] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 4935.912830] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 4935.919555] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 4935.926561] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 4935.933274] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 4935.938727] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 4935.944746] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 4935.950698] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 4935.956474] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 4935.961793] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 4935.968035] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 4935.973980] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 4935.978798] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 4935.984615] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 4935.991090] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 4935.996993] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 4936.002766] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 4936.009644] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 4936.015952] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 4936.022038] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 4936.028495] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 4936.034488] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 4936.041478] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 4936.046988] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 4936.052474] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 4936.058368] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 4936.064586] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 4936.070661] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 4936.077780] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 4936.082299] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 4936.088032] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 4936.094093] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 4936.099759] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 4936.105678] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 4936.111594] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 4936.117784] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4936.123774] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 4936.129479] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4936.135032] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4936.140432] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 4936.146437] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4936.151840] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 4936.158204] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 4936.165011] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 4936.170900] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 4936.176662] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 4936.182837] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 4936.188732] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 4936.194185] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 4936.200859] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 4936.206473] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 4936.216133] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 4936.225847] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 4936.235000] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 4936.244256] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 4936.253415] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 4936.263549] [   T3317]  </TASK>
kern  :err   : [ 5427.326351] [   T3317] INFO: task modprobe:14010 blocked for more than 4915 seconds.
kern  :err   : [ 5427.335241] [   T3317]       Not tainted 7.0.0-rc1-00007-g2a93f5747d0e #1
kern  :err   : [ 5427.343857] [   T3317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kern  :info  : [ 5427.353900] [   T3317] task:modprobe        state:D stack:0     pid:14010 tgid:14010 ppid:13990  task_flags:0x400100 flags:0x00080000
kern  :info  : [ 5427.368327] [   T3317] Call Trace:
kern  :info  : [ 5427.372190] [   T3317]  <TASK>
kern  :info  : [ 5427.375618] [   T3317]  __schedule (kernel/sched/core.c:5295 kernel/sched/core.c:6907)
kern  :info  : [ 5427.380680] [   T3317]  ? _printk (kernel/printk/printk.c:2504)
kern  :info  : [ 5427.385898] [   T3317]  ? __pfx___schedule (kernel/sched/core.c:7800 (discriminator 1))
kern  :info  : [ 5427.391445] [   T3317]  ? mutex_unlock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4480 kernel/locking/mutex.c:169 kernel/locking/mutex.c:549)
kern  :info  : [ 5427.396646] [   T3317]  ? prepare_to_wait_event (kernel/sched/wait.c:317 (discriminator 1))
kern  :info  : [ 5427.402788] [   T3317]  schedule (kernel/sched/core.c:6989 kernel/sched/core.c:7004)
kern  :info  : [ 5427.408086] [   T3317] dmatest_init (drivers/dma/dmatest.c:1352 (discriminator 7)) dmatest
kern  :info  : [ 5427.415197] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 5427.421924] [   T3317]  ? __pfx_autoremove_wake_function (include/linux/list.h:418 (discriminator 4))
kern  :info  : [ 5427.429814] [   T3317]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
kern  :info  : [ 5427.434782] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 5427.441589] [   T3317]  ? trace_initcall_start_cb (init/main.c:1315)
kern  :info  : [ 5427.447828] [   T3317]  ? __pfx_dmatest_init (dmatest.c:?) dmatest
kern  :info  : [ 5427.454983] [   T3317]  do_one_initcall (init/main.c:1382)
kern  :info  : [ 5427.460334] [   T3317]  ? __pfx_do_one_initcall (include/trace/events/initcall.h:10)
kern  :info  : [ 5427.466450] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 5427.471781] [   T3317]  ? __kasan_slab_alloc (mm/kasan/common.c:336 mm/kasan/common.c:366)
kern  :info  : [ 5427.478061] [   T3317]  ? kasan_unpoison (mm/kasan/shadow.c:146 mm/kasan/shadow.c:178)
kern  :info  : [ 5427.483385] [   T3317]  do_init_module (kernel/module/main.c:3039)
kern  :info  : [ 5427.488819] [   T3317]  ? __pfx_do_init_module (include/linux/list.h:203)
kern  :info  : [ 5427.494734] [   T3317]  ? kfree (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6442)
kern  :info  : [ 5427.499928] [   T3317]  ? klp_module_coming (kernel/livepatch/core.c:1321)
kern  :info  : [ 5427.505740] [   T3317]  load_module (kernel/module/main.c:3509)
kern  :info  : [ 5427.511146] [   T3317]  ? ima_post_read_file (security/integrity/ima/ima_main.c:931 (discriminator 1) security/integrity/ima/ima_main.c:913 (discriminator 1))
kern  :info  : [ 5427.518030] [   T3317]  ? __pfx_load_module (kernel/module/main.c:2947)
kern  :info  : [ 5427.523644] [   T3317]  ? security_kernel_post_read_file (security/security.c:2894 (discriminator 8))
kern  :info  : [ 5427.530488] [   T3317]  ? kernel_read_file (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:435 include/linux/fs.h:2806 fs/kernel_read_file.c:122)
kern  :info  : [ 5427.536328] [   T3317]  ? __pfx_kernel_read_file (??:?)
kern  :info  : [ 5427.542416] [   T3317]  ? init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 5427.549007] [   T3317]  init_module_from_file (kernel/module/main.c:3712)
kern  :info  : [ 5427.555000] [   T3317]  ? __pfx_init_module_from_file (kernel/module/main.c:3569)
kern  :info  : [ 5427.561721] [   T3317]  ? kasan_save_track (mm/kasan/common.c:78)
kern  :info  : [ 5427.567225] [   T3317]  ? _raw_spin_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:154)
kern  :info  : [ 5427.573110] [   T3317]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:327)
kern  :info  : [ 5427.579003] [   T3317]  ? kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2687 mm/slub.c:6124 mm/slub.c:6254)
kern  :info  : [ 5427.584659] [   T3317]  idempotent_init_module (kernel/module/main.c:3724)
kern  :info  : [ 5427.590753] [   T3317]  ? __pfx_idempotent_init_module (kernel/module/main.c:3713)
kern  :info  : [ 5427.597990] [   T3317]  ? fdget (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:49 fs/file.c:1196 fs/file.c:1210)
kern  :info  : [ 5427.602509] [   T3317]  ? security_capable (security/security.c:634 (discriminator 8))
kern  :info  : [ 5427.608248] [   T3317]  __x64_sys_finit_module (kernel/module/main.c:3750 kernel/module/main.c:3734 kernel/module/main.c:3734)
kern  :info  : [ 5427.614244] [   T3317]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :info  : [ 5427.619999] [   T3317]  ? __pfx_do_sys_openat2 (fs/open.c:1270 (discriminator 4))
kern  :info  : [ 5427.625898] [   T3317]  ? __x64_sys_pread64 (fs/read_write.c:765 fs/read_write.c:773 fs/read_write.c:770 fs/read_write.c:770)
kern  :info  : [ 5427.631801] [   T3317]  ? __pfx___x64_sys_pread64 (include/linux/fsnotify.h:88)
kern  :info  : [ 5427.637991] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 5427.643995] [   T3317]  ? __x64_sys_openat (fs/open.c:1372 fs/open.c:1388 fs/open.c:1383 fs/open.c:1383)
kern  :info  : [ 5427.649680] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 5427.655203] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 5427.660596] [   T3317]  ? __pfx_pgd_none (arch/x86/include/asm/pgtable.h:1058)
kern  :info  : [ 5427.666313] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 5427.671704] [   T3317]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:548)
kern  :info  : [ 5427.678128] [   T3317]  ? lock_vma_under_rcu (include/linux/rcupdate.h:883 mm/mmap_lock.c:329)
kern  :info  : [ 5427.684015] [   T3317]  ? count_memcg_events (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 mm/memcontrol.c:563 mm/memcontrol.c:586 mm/memcontrol.c:567 mm/memcontrol.c:857)
kern  :info  : [ 5427.690948] [   T3317]  ? handle_mm_fault (include/linux/rcupdate.h:883 include/linux/memcontrol.h:987 include/linux/memcontrol.h:993 mm/memory.c:6488 mm/memory.c:6649)
kern  :info  : [ 5427.696540] [   T3317]  ? do_syscall_64 (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:256 include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
kern  :info  : [ 5427.702161] [   T3317]  ? do_user_addr_fault (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:196 include/linux/mmap_lock.h:217 include/linux/mmap_lock.h:264 arch/x86/mm/fault.c:1336)
kern  :info  : [ 5427.708457] [   T3317]  ? irqentry_exit (include/linux/irq-entry-common.h:228 include/linux/irq-entry-common.h:270 include/linux/irq-entry-common.h:339 kernel/entry/common.c:219)
kern  :info  : [ 5427.713759] [   T3317]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
kern  :info  : [ 5427.720573] [   T3317] RIP: 0033:0x7ff7b0dc6779
kern  :info  : [ 5427.725585] [   T3317] RSP: 002b:00007ffd9ea66b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kern  :info  : [ 5427.735790] [   T3317] RAX: ffffffffffffffda RBX: 0000562674233ae0 RCX: 00007ff7b0dc6779
kern  :info  : [ 5427.744917] [   T3317] RDX: 0000000000000000 RSI: 0000562674233c80 RDI: 0000000000000004
kern  :info  : [ 5427.754079] [   T3317] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :info  : [ 5427.763499] [   T3317] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562674233c80
kern  :info  : [ 5427.772651] [   T3317] R13: 0000000000040000 R14: 0000562674233c00 R15: 0000000000000000
kern  :info  : [ 5427.784207] [   T3317]  </TASK>
kern  :info  : [ 5427.787679] [   T3317] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
user  :notice: [ 7564.746350] [   T5531] Tue Mar 10 02:44:33 UTC 2026 detected soft_timeout

user  :err   : [ 7565.302612] [   T5533] Terminated



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260512/202605122202.4673084b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



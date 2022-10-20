Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07E606484
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJTPag (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiJTPaS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 11:30:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F2F07D8;
        Thu, 20 Oct 2022 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666279804; x=1697815804;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e7b/wCbppjhvEoV3ynbf8YcyASdSKBML2a21wfYgNGQ=;
  b=O+Ml23SbVPL3iob/8nEKFd/y6hKBDGtE5hKMllVZfFnpFp2+kIJl2W/7
   ZRIi8I9U2AG+DX4jG+Jcrd6csooreZrR6HkLRNzEMJKwtx1sXICHrnWiG
   9Q9WPdC9xD5fDANff7mh+f50WPDgIhGBDT+BpPlydSXeXUJNj7L8z8qEj
   GxEM9EIQqRbvcMGMQGtAYn7vjTlrM9SXcPTWz0QzNTpVTgIcVsmof+7tk
   u5BF/2Gs0ELIx69aOyJqtgt5gmJC+n5Td+fTjBI2CL+fBVhfpBAzwXoVi
   5aI1cOlv5qCqQev972awENqVLT4Mx1Q0j5wJPBI5lSMBHHIGJHPL954zZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="307842142"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="307842142"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 08:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="698727945"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="698727945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2022 08:28:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 08:28:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 08:28:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 08:28:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 08:28:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLODxaWXe6XkEyZ5pVXaqfCxWGEaf1rJ0rfCloxysUNIEOwczI+x/Pk98MXnree2prSJWz0caxbmK/9VzjfMGWbeRjm/bSMEgdpNYml063d4J8quTVVwDMEoxr2IPTqvaeV77yoQwZ3Y77SsqT2zcu8FXi2q+7qcO4CZMGCT97ykPSi3P7LVm/bGsYvjyeLjAjDhiCGBZX5v+KyAERLFL7Xh1FUHxYj6Q+ZHCNSf+keDJS3i+unTUMtQIOhXB//jz2bERlugTnNBK+/n8NhXFCYRKzrCZCbkiQhQoi56sitiQnTQvHb0sIRUfQzcXY6VLyUq/rPdCpC4kdZeUMzkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11wQ/2JbPUuK+B+PzDj80duEeQ2bwYOOj3I9UD4g4lI=;
 b=Lp8NI4CrfCPJxSDH/QPVyw76aU9qgR/ewahpp81REO5cPDtbWgAV+kq/Tf0EyT2CBLSrqBHLWQjKBTRxfJQqZIiI39UZPwxlT7ADOzBCF2dpTeT8hzVAVX89EA8mWyGunvy2TreW3HlE3d4lYPM/CVkEYOs/ZNqIdjWLEOokSLESy3tPmH5iHyWLtyNiaBAqbyjAyZKwfg7h0WbnxdT91qCsHk/7nNlB+9iAqTqb4iea84NWGBVTqbpM6veVlkkb7/HXs23uAuhUzrqMajAmcinVf4R2gzrSllt1TdGnH9UDeu0fC42VHC6OIh4TgQ2mYpfo/6iGvzJCYNErm5buUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CO1PR11MB5060.namprd11.prod.outlook.com
 (2603:10b6:303:93::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 15:28:56 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Thu, 20 Oct
 2022 15:28:56 +0000
Date:   Thu, 20 Oct 2022 08:28:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Subject: RE: [PATCH] MAINTAINERS: remove section INTEL IOP-ADMA DMA DRIVER
Message-ID: <635169355dc60_4da329438@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221020082103.29218-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221020082103.29218-1-lukas.bulwahn@gmail.com>
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CO1PR11MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d554497-dc4b-429a-d3d5-08dab2afcd3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPOppUbUxpUEC5gpuKCnIq1DYkn7L9dTge4iE+fT+YKLcq0SiY4AZXnETyorMi+0YACRD6gyN4BRQ06lwLe4AsidnF6Jevk9djdtArWWfTy50BOHUnr7PZOH+e7iSOrPiwbGd0gCmiIR5IlvPNLDagIoUrc2R3dv4PebT5f0fve2eznEwC7ISnG65O/L7BBwG44nvosdsh88xr8lCBr3Rp0pLLf86W+RvYyVXgYav5onXWswxYgSxlBrnTIDV15kUbKXB0Ral3kf6IdXzloCyPfZfqTBipB9eMjQqTu2DakAVijgRZkBwHcWWO/xs2saW4cy8Mo5abCYleen/jKxG7+33itoyvxDgQShJU1ZJYLCU69VNSA/EWbaKnsusPLdZ4cmCjJci8SPWNSiFgb175skHqbt2Cw+EovAsFZCgalSRd/sB2gux84pUQDMuOGm3nM3A6NUxZUUp8o3U/zkbQcntx/y6GIXv5+PUuf88xb2gYpTnX6MVt8Qp+MSAgqpUN8xb9gLOkZ5BpnInJ7uuS1lf/n5QIfWRqGMbUI6rh3MwR2tA5/4ulWjV5IJa/SkhnqNVnJz/JkLpkPIlT7cXyaXMVWNw/fMY9/yl6SndtCMiPIq5HLmM6K06fQb4xeu/qXZQHvbuY3p0iO43aj+y3y/mwPKXGkQpgeWGJc2BQfy7W529ZE41S0Gy/OvjMvXbE43LLWUsudTqdIA1FFQgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(66476007)(2906002)(186003)(41300700001)(8676002)(4326008)(6506007)(6666004)(86362001)(82960400001)(9686003)(26005)(66946007)(54906003)(316002)(8936002)(38100700002)(110136005)(66556008)(4744005)(5660300002)(6512007)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMkJSFd6MSa6YKnYR32uJ5uQuyoymUUC8CGxm3ROHyZF8mmFFghVLoQQVeDb?=
 =?us-ascii?Q?EwntnpHv1rtHPhLehj4ttigp6zm1Fq2Vv0MMDmNbRFxzSJ7Je0eUFZNuqO23?=
 =?us-ascii?Q?+VOqkPWfSRP3ZsfUjdp0/zIqVVlyu+No7bjUfpTLHQ7a3FX3jdhyLBo8utXr?=
 =?us-ascii?Q?c3gCnXT1i0Uqa3ZepKsPoKDpPCxvny2W7xqBAmmjgKKUf5ksI/uAcooPY1R3?=
 =?us-ascii?Q?QvGSd2a87ujlqxt5gcAPFSiBegVujI0aGEKCB6V1TApg9csDrx7M7C4Wfiw1?=
 =?us-ascii?Q?KbC+0Ot4CGH8uzXIB9kcDfNtCrP+NqeLmmBJG7zrK9VMAdwwZ/yHga1irJgr?=
 =?us-ascii?Q?qUHqOISY27m/vMYRwHKOYIRsgmUu0Ei7T6r6ZoU3CvsCAfcyz+enelmzMvqz?=
 =?us-ascii?Q?6XInjYy/QA5xGjunh40or2YkZ+0oaF9GZzKO8Q+xfQaQI5+mfv8R8mHFKlNG?=
 =?us-ascii?Q?JBNYz3UHDnY76hfh6cIAKnk3l9++q3yQSa5Q0ZHG0h8QChTa92Yqb+YFEp3A?=
 =?us-ascii?Q?AeTvm/XTBSmXyWMSiZdakkT9SVVeu6KG0A4fN6jKbWRpmjDO1DbxQzNyUJ8t?=
 =?us-ascii?Q?qrEdTTV1zeD2l652/QIq7iI59D0eF/EwdH4rO4iq+upD7c7lU2ZmzCDhhsXe?=
 =?us-ascii?Q?e6crHQngyirMAwSZUapNgPXpRyh6n34qo9gC2PSGm5KBUEzVf2cRzarQ7lVa?=
 =?us-ascii?Q?E9yvGMaDikj5prPT+VayOJwrbChFjcIgQqMTE1tNEOJkMh8PB33CmrBixEEz?=
 =?us-ascii?Q?0RD/O76r3oP5Xd6/AlaSbvi1zAiWymM9JiqRqlqLXUDsqNVCRvYII7WV++QT?=
 =?us-ascii?Q?GE7/+mJVT94xdt7+DuUkBI7O7qiR/kJ9ShCVbLV8cQtCSqP5EHjDO1PQP38l?=
 =?us-ascii?Q?11/LIwSBat4WXOZ90jQJMfzTVoPmNNCfGi/UxPZ1Pj7ku10n+MmYmOhDTYR7?=
 =?us-ascii?Q?dXhjsUqnLe4qDF/7ZrxvofQb0Vd3Cn4PwoA5Ht/DeAzpWdhiptg5W9SiI1wJ?=
 =?us-ascii?Q?lFMNTsW7MO9x1E6c5hkCXnXlBa+FCc6Zh8rftSxbg0cKbH/zcllE9T9C7txq?=
 =?us-ascii?Q?bQ9Yyy2vFIAXqXnIMR2/6j1ZvyBzYJjYYlOs1xz3rFaPFsT5L7G5roI5aNsk?=
 =?us-ascii?Q?4mDqdNE3WdWAHT066foaiToIUHIR91EMU4WmOIPhwqP2Mh4q0mqivWZqqPjc?=
 =?us-ascii?Q?m33j+Sy7aoKFR7/jYSP6QvTCC9e6IfYI6E+puaYUtMjx3fZ557AMFUtvGL67?=
 =?us-ascii?Q?xw+Zc7K+AcuGZlXlcZmX82M/lduEKfUi9KgrcUcaHVNBVtwRTKzSzHIkapV/?=
 =?us-ascii?Q?fIwYqUK8IwzTKBDsjH/q1tLnGKXv0Svm9lk0rI699BRpavpqCMyV8Z3yhKck?=
 =?us-ascii?Q?3+bHSTr+l9A2t/LPJCrXPRlD9nK0/VABE5zM6WntIyy8SCGlg3SGXszu137i?=
 =?us-ascii?Q?QK1eDX5HFD9C7eV0KfMIRLb5HvU5mn+LDXv8A3PUNTgxZ+RzI9e7khWlJb3k?=
 =?us-ascii?Q?7vxA3Zj+bOV5y/uqL/7H7teWpPabfYjzIuEXEMFM7NypdZiD+orEdRndCc5o?=
 =?us-ascii?Q?TAd/Tpb8CXiSpLaulHu9kvRwT86qeph/l/JViK4JNzrX1NiHCSVtujq+DeVd?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d554497-dc4b-429a-d3d5-08dab2afcd3d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:28:56.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehu1dEPEXbX/yElxxsuAUOZuAdCZKfn33l7/JD8cv6UKN4oDZkS1IMooiTlBozD1+k+t8wFvHgcBZvTVaGrABd6sV9+nIawNfzJgunxW2dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Lukas Bulwahn wrote:
> Commit cd0ab43ec91a ("dmaengine: remove iop-adma driver") removes the
> driver's source code, but misses to remove the MAINTAINERS section.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken file pattern.
> 
> Remove the INTEL IOP-ADMA DMA DRIVER section pointing to the removed
> driver.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
